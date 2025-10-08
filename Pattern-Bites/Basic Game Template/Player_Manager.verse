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

# Player_Manager.verse
# Version: beta 1.0

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# player_manager
player_manager := class(creative_device):
    # System
    @editable PDM : player_data_manager = player_data_manager{}
    # Device
   
    # Value
    var PlayerBOX : []player = array{}
    var PlayerGameData : [player]?player_game_data = map{}

    # OnBegin
    OnBegin<override>()<suspends>:void=
        Playspace := GetPlayspace()
        Playspace.PlayerAddedEvent().Subscribe(OnPlayerAdded)
        Playspace.PlayerRemovedEvent().Subscribe(OnPlayerRemoved)
        # Initialize existing players
        for (Player : Playspace.GetPlayers()):
            OnPlayerAdded(Player)

# :: Player Spawner Functions :: 
    # On Player Added  
    OnPlayerAdded(Player:player):void=
        if (not PlayerBOX.Find[Player]):        # If the player is already saving, do not perform the action
            set PlayerBOX += array{Player}      # Add Player
            PDM.CreatePersistable(Player)       # Check whether persistable data was created
            PlayerGameInit(Player)              # Game Initialization
        else:
            Print("Debug: PM: OnPlayerSpawned Error!") # Debug   
            
    # On Player Removed
    OnPlayerRemoved(Player:player):void=
        OnExitSession(Player)
        spawn {HandlePlayerRemoved(Player)}       

    # Handle Player Removed
    HandlePlayerRemoved(Player:player)<suspends>:void=
        # Pause briefly to give other active threads buffer time to finish processing
        #   @Stop the related asynchronous threads and release the device for use by other players
        Sleep (3.0)
        set PlayerBOX = PlayerBOX.RemoveAllElements(Player)

# :: Player Game Session Functions ::
    # Player Game Init
    PlayerGameInit(Player:player):void=
        if (set PlayerGameData[Player] = option {player_game_data{ Player := Player }} ):
            if (PGD := PlayerGameData[Player]?):
                PGD.Init()

    # On Exit Session
    OnExitSession(Player:player):void=
        RemovePlayerData(Player)

    # Remove Player Data    
    RemovePlayerData(Player:player):void=            
        if (set PlayerGameData[Player] = false){}

    # @Add more game functions...


# :: GM Functions ::

    # GM Use Reset PDM  
    GM_ResetPDM(Player:player):void=
        PDM.ResetData(Player)


