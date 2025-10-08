# ═════════════════════════════════════════════════════════════════════════════
#   Verse-Bites: Pattern-Bites - Basic Game Template
#   Author: UnrealRider
#   Project Homepage:   https://github.com/UnrealRider/Verse-Bites
# -----------------------------------------------------------------------------
#   Copyright & License:
#   Copyright (c) 2025 UnrealRider
#   This project is licensed under the terms of the MIT License.
#   The full license text can be found at: https://github.com/UnrealRider/Verse-Bites/tree/main?tab=MIT-1-ov-file
# ═════════════════════════════════════════════════════════════════════════════

# Player_Data_Manager.verse
# Version: beta 1.0

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Random }

# weak_map
var PersistableMap : weak_map(player, player_data) = map{}

# Persistable
player_data := class<persistable><final>:
    Version : int = 1
    UniqueID : int = -1
    Gold : int = 0
    BeginnerTraining : logic = false
    # @Add New Field

# Update Playe Data
UpdatePlayerData<constructor>(Src:player_data)<transacts> := player_data:
    Version := Src.Version
    UniqueID := Src.UniqueID
    Gold := Src.Gold
    BeginnerTraining := Src.BeginnerTraining
    # @Add New Field
        # Whenever a Field is added to player_data, the corresponding Field must be added here

# Enum for data fields
    # Whenever a Field is added to player_data, the corresponding Field must be added here
EPDM := enum {Version, UniqueID, Gold, BeginnerTraining}  # @Add New Field

# player_data_manager
player_data_manager := class(creative_device):

    # Create Persistable
    CreatePersistable(Player:player):void=
        if (not PersistableMap[Player]):
            if (set PersistableMap[Player] = player_data{}):
                UniqueID := GetRandomInt(10000000000, 99999999999)
                if (SaveInt[Player, EPDM.UniqueID, UniqueID]){}

    # Reset Data for GM Mode     
    ResetData(Player:player):void=
        if (Player.IsActive[]):
            # Restore stored UniqueID after reset
            GetUniqueID := GetInt(Player, EPDM.UniqueID)
            if (set PersistableMap[Player] = player_data{}):
                if (SaveInt[Player, EPDM.UniqueID, GetUniqueID]){}

# :: GET Functions ::
    # Get Player Data Base Function
    GetPlayerData(Player:player): player_data =
        PersistableMap[Player] or player_data{}
        
    # Get Int
    GetInt(Player:player, Field:EPDM):int=
        if (Player.IsActive[]):
            gPlayerData := GetPlayerData(Player)
            if (Field = EPDM.Version) { gPlayerData.Version }
            else if (Field = EPDM.UniqueID) { gPlayerData.UniqueID }
            else if (Field = EPDM.Gold) { gPlayerData.Gold }
            # @Add New Data...
        else:
            Print("PDM GetInt 404")
        return -404

    # Get Logic
    GetLogic(Player:player, Field:EPDM):logic=
        if (Player.IsActive[]):
            gPlayerData := GetPlayerData(Player)
            if (Field = EPDM.BeginnerTraining) { gPlayerData.BeginnerTraining }
            # @Add New Data...
        else:
            Print("PDM GetInt 404")
        return false


# :: SAVE Functions ::
    # Save Int        
    SaveInt(Player:player, Field:EPDM, NewValue:int)<decides><transacts>:void=
        if:
            Player.IsActive[]
            CurrentData := PersistableMap[Player] or player_data{}
        then:
            UpdatedData := case(Field):
                EPDM.Version   => player_data{ UpdatePlayerData<constructor>(CurrentData), 
                    Version := NewValue }
                EPDM.UniqueID  => player_data{ UpdatePlayerData<constructor>(CurrentData), 
                    UniqueID := NewValue }
                EPDM.Gold      => player_data{ UpdatePlayerData<constructor>(CurrentData), 
                    Gold := NewValue }
                # @Add New Data...
            if (set PersistableMap[Player] = UpdatedData) {}
        else:
            Print("PDM SaveInt ERROR!")

    # Save Logic        
    SaveLogic(Player:player, Field:EPDM, NewValue:logic)<decides><transacts>:void=
        if:
            Player.IsActive[]
            CurrentData := PersistableMap[Player] or player_data{}
        then:
            UpdatedData := case(Field):
                EPDM.BeginnerTraining    => player_data{ UpdatePlayerData<constructor>(CurrentData), 
                    BeginnerTraining := NewValue }
                # @Add New Data...
            if (set PersistableMap[Player] = UpdatedData) {}
        else:
            Print("PDM SaveLogic ERROR!")
