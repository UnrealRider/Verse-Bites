# ═════════════════════════════════════════════════════════════════════════════
#   Verse-Bites: Lesson-Bites (UEFN Verse Tutorial)
#   Author: UnrealRider
#   Project Homepage:   https://github.com/UnrealRider/Verse-Bites
#   Description: This Verse file contains the complete source code for the Verse-Bites: Lesson-Bites Level 1-2 tutorial series (Lessons 30-40).
# -----------------------------------------------------------------------------
#   Copyright & License:
#   Copyright (c) 2025 UnrealRider
#   This project is licensed under the terms of the MIT License.
#   The full license text can be found at: https://github.com/UnrealRider/Verse-Bites/tree/main?tab=MIT-1-ov-file
# ═════════════════════════════════════════════════════════════════════════════

# --- Lesson Content Starts Below ---

# Lesson-Bites Level 1-2
# Version: beta 1.3

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }


# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 30 – suspends, spawn & Sleep
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn the concepts of synchronous and asynchronous in Verse, and master how to use `suspends`, `Sleep`, and `spawn` to create timed events and concurrent tasks.

# Up to now, all our code has been "Synchronous".
# The execution process of synchronous code is linear; each action must be completed step-by-step before the next task can be executed.
# But in games, we often need to "wait" (like a trap with a delayed explosion) or have tasks run "simultaneously" (like multiple mechanisms operating in parallel).
# This requires Asynchronous and Concurrency.

# bites_suspends
bites_suspends := class(creative_device):
    @editable TRIG_1 : trigger_device = trigger_device{}
    @editable TRIG_2 : trigger_device = trigger_device{}
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        TRIG_1.TriggeredEvent.Subscribe(OnTRIG_1)
        TRIG_2.TriggeredEvent.Subscribe(OnTRIG_2)
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)

    # --------------------------------------------------------------------------
    # Example 1: Synchronous vs. Asynchronous - Instant Explosion vs. Delayed Explosion
    # --------------------------------------------------------------------------

    # OnTRIG_1 and TriggerTrap_A are both synchronous.
    OnTRIG_1(oAgent:?agent):void =
        Print("Stepped on trap A!")
        TriggerTrap_A()       # After the flow enters this function, it must wait for it to complete before the next piece of code can run.
        Print("Explosion finished")   # So this Print will only be printed after TriggerTrap_A() is done.

    # This is a synchronous function, all its code will be executed immediately.
    TriggerTrap_A():void=
        # Sleep(3.0)        # ❌ The Sleep() syntax can only be used in methods with <suspends>.
        Print("Boom! Trap A exploded!")

    # Now we want the trap to be delayed, so we need to use an asynchronous method.
    OnTRIG_2(oAgent:?agent):void =
        Print("Stepped on trap B...")
        # The `spawn {}` syntax will generate a new thread, and you set the function to be triggered, `TriggerTrap_B()`, in `{}`.
        spawn { TriggerTrap_B() }
        Print("The trap is still counting down...")

    # An asynchronous function must have the `<suspends>` specifier and can only be called using the `spawn {}` syntax.
    # TriggerTrap_B() has `<suspends>` added, now it's an asynchronous function.
    TriggerTrap_B()<suspends>:void=
        Print("Trap B tick.. tock..")
        # `Sleep(seconds:float)` is a syntax that can only be used by asynchronous functions.
        Sleep(3.0)      # When the program executes to Sleep, it will stop here and count down according to the configured seconds. Only after the countdown is complete will the code below be executed.
        Print("(After 3 seconds)... Boom! Trap B exploded!")

    # Tips: In this case, you can trigger `OnTRIG_2` multiple times. Each time you trigger it, a new parallel asynchronous process will be generated.

    # --------------------------------------------------------------------------
    # Example 2: Managing the State of Asynchronous Tasks - Preventing the Rocket from Firing Repeatedly
    # --------------------------------------------------------------------------
    # To avoid the problem of TriggerTrap_B() being triggered repeatedly, we need to design some helper logic.

    # Solution: A variable is needed to identify the launch state of the rocket.
    var IsLaunch : logic = false    

    OnBTN_1(Agent:agent):void =
        if (IsLaunch?):
            Print("The rocket has already been launched.")
        else:
            set IsLaunch = true         # If the rocket has not been launched, set it to true and call the asynchronous function LaunchRocket().
            Print("Rocket launch button pressed.")
            spawn { LaunchRocket() }    

    # Sleep can be used multiple times in an asynchronous function to implement complex timing control.
    LaunchRocket()<suspends>:void=
        Print("Rocket launch countdown begins...")
        Sleep(2.0)
        Print("3...")
        Sleep(1.0)
        Print("2...")
        Sleep(1.0)
        Print("1...")
        Sleep(1.0)
        Print("Launch! 🚀 Boom! Boom! Boom!")
        Sleep(2.0)
        Print("Launch sequence finished, can launch again.")
        set IsLaunch = false    # After launch and cooldown are complete, set IsLaunch to false for the next launch.


    # --------------------------------------------------------------------------
    # Example 3: Calls Between Asynchronous Functions - Serial vs. Parallel
    # --------------------------------------------------------------------------
    # We learned earlier that an asynchronous function must be called using the `spawn {}` syntax.
    #   However, within one asynchronous function, it is possible to directly call another asynchronous function without using the `spawn {}` syntax.
    #   But! The result is completely different with and without `spawn {}`.

    # Process A: Serial execution (like a relay race) ─────────────────────────
    OnBTN_2(Agent:agent):void =
        Print("Process A started (relay race mode)")
        spawn { Countdown_A1() }
    
    # The result here will be similar to the flow of `Example 1`-`OnTRIG_1`.
    Countdown_A1()<suspends>:void=
        Print("A1: A2, you run first.")
        Countdown_A2()          # After the flow enters this function, it must wait for it to complete before the next piece of code can run.
        Print("A1: Starting to run...")   # So similarly, this Print will only be printed after Countdown_A2() is done, and will continue to execute the Sleep after it.
        Sleep(2.0)
        Print("A1: Finished")
 
    Countdown_A2()<suspends>:void=
        Print("A2: Starting to run...")
        Sleep(3.0)
        Print("A2: Finished")

    # Why? What is the purpose of serial asynchronous functions?
    #   This is to allow multiple functions to use features with the `<suspends>` characteristic, like Sleep.
    #   At the same time, it maintains a synchronous execution flow.
    #   You can try removing `<suspends>` from `Countdown_A2()`, and Sleep will then report an error!


    # Process B: Parallel execution (starting almost at the same time) ─────────────────────────
    OnBTN_3(Agent:agent):void =
        Print("Process B started (simultaneous start mode)")
        spawn { Countdown_B1() }

    # B1 calls B2 using spawn, which means B1 【does not wait】 for B2; both start their timers at the same time.
    Countdown_B1()<suspends>:void=
        Print("B1: B2, let's run together!")
        spawn { Countdown_B2() }    # The flow generates a new thread that runs simultaneously, so it doesn't need to wait for Countdown_B2() to finish.
        Print("B1: Starting to run...")
        Sleep(2.0)                  # Although they run at almost the same time, B1 only takes 2 seconds, so B1 will finish first.
        Print("B1: Finished")

    Countdown_B2()<suspends>:void=
        Print("B2: Starting to run...")
        Sleep(3.0)
        Print("B2: Finished")


    # ✨ Extended Observation    
    #   Noticed? The OnBegin we've been using all along is an asynchronous function with `<suspends>`.
    #   This means that every Verse Device you place in the scene runs in its own independent asynchronous process at the start of the game, without interfering with each other.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 31 – loop & break & return
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn to use `loop` to create infinite loops, and master how to use `break` and `return` to precisely control when to exit the loop.

# Review of `for` loops: It's used to iterate over a 【known, finite】 collection (like an array).
# Introduction to `loop`: It's used to create an 【infinite】 loop that only stops when a specific condition is met.
# `loop` is very suitable for creating logic that needs to run continuously, like a timer, a game's main loop, or a mechanism that constantly checks a player's position.
# In this lesson, we will make a timer.

bites_loop := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}
    @editable BTN_4 : button_device = button_device{}
    @editable BTN_5 : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
        BTN_4.InteractedWithEvent.Subscribe(OnBTN_4)
        BTN_5.InteractedWithEvent.Subscribe(OnBTN_5)

    # --------------------------------------------------------------------------
    # Example 1: Creating a timer using a loop
    # --------------------------------------------------------------------------
    var Timer_A_IsRunning : logic = false   # Used to identify the running state of the timer
    var Timer_A : float = 0.0               # Current time
    Timer_A_Max : float = 7.0               # Target time
    
    OnBTN_1(Agent:agent):void =
        if (Timer_A_IsRunning = false):     # Check the timer's state to avoid re-triggering
            set Timer_A_IsRunning = true    # Lock it to prevent re-triggering
            spawn { CountDown_A() }         # `loop` can also only run in a `<suspends>` function

    # This is timer A
    CountDown_A()<suspends>:void=
        Print ("Timer A starts counting")        # This line runs before the loop, so it's executed only once
        loop:                                    # This is the `loop:` syntax, the loop's scope starts from the next line
            # <<< This is the start of the loop
            if (Timer_A_IsRunning = false):      # If a stop state is detected, use break to end the thread
                Print ("Timer A has stopped")     
                break                            # A `loop` must be paired with `break` to exit the loop, otherwise it will cause an infinite loop
            else if (Timer_A >= Timer_A_Max):    # If the time is up, use break to end the thread
                Print ("Timer A Time Up!")  
                break                            # Even if we need a never-ending timer, a `break` is still required, otherwise Verse will report an error
            Sleep (1.0)                          # Here we use Sleep to implement a one-second timer
            set Timer_A += 1.0                   # Refresh `Timer_A` after each tick
            Print ("Timer_A = {Timer_A}")        # Print the current seconds
            # <<< The loop ends here, then returns to the start
        CountDown_A_Reset()

    # Reset state and seconds      
    CountDown_A_Reset():void=
        set Timer_A_IsRunning = false    
        set Timer_A = 0.0  

    # --------------------------------------------------------------------------
    # Example 2: Creating an infinite-looping timer
    # --------------------------------------------------------------------------
    var Timer_B_IsRunning : logic = false      
    var Timer_B : float = 0.0      
    Timer_B_Max : float = 7.0  
    var TimerLoopCount : int = 0 

    # Trigger logic is the same as Example 1
    OnBTN_2(Agent:agent):void =
        if (Timer_B_IsRunning = false):
            set Timer_B_IsRunning = true    
            spawn { CountDown_B() }

    # This is timer B
    CountDown_B()<suspends>:void=
        loop:
            if (Timer_B_IsRunning = false):      # Here we only use the stop functionality
                break
            Sleep (1.0)
            set Timer_B += 1.0
            Print ("Timer_B = {Timer_B}")
            if (Timer_B >= Timer_B_Max ):      # The main difference is here, when the seconds reach the max value, it resets to 0 and continues counting
                set TimerLoopCount += 1
                set Timer_B = 0.0
                Print ("Timer B has completed {TimerLoopCount} rounds!") 

    CountDown_B_Reset():void=
        set Timer_B_IsRunning = false    
        set Timer_B = 0.0  

    # This handles the stop function for both Example 1 and 2      
    OnBTN_3(Agent:agent):void =
        StopAll()

    # Reset the state and timer seconds for both examples    
    StopAll():void=
        CountDown_A_Reset() 
        CountDown_B_Reset()

    # --------------------------------------------------------------------------
    # Example 3: `return` - Exiting the 【Function】 Early
    # --------------------------------------------------------------------------
    # Using return in a for loop will cause the program to exit the for loop directly
    # This way, the program finishes its work after completing the target task, and does not continue to perform unnecessary calculations
    # Scenario: We want to find a "lucky number" in an array. Once found, there's no need to continue searching.

    IntBOX : []int = array{1,2,3,4,5,6,7,8,9}            
    MyLuckNumber : int = 5            

    OnBTN_4(Agent:agent):void =
        for (Index -> Value : IntBOX):
            if (Value = MyLuckNumber):
                Print ("Found my lucky number {MyLuckNumber}!")
                return      # After finding the lucky number, the program directly exits the for loop via return
            else:
                Print ("This is {Value}, still looking...")   
        Print ("Could not find the number!")       


    # --------------------------------------------------------------------------
    # Example 4: The Essential Difference Between `return` and `break`
    # --------------------------------------------------------------------------
    # `break`: like finishing a chapter in a book, exiting the 【loop】, and continuing to the next page (the code after the loop).
    # `return`: like closing the entire book, exiting the 【entire function】.

    # return can also be used in a loop, but the result is different from break
    OnBTN_5(Agent:agent):void =
        if (Timer_C_Play = false):
            set Timer_C_Play = true
            spawn { Countdown_WithReturn() }
            spawn { Countdown_WithBreak() }

    var Timer_C_Play : logic = false   
    TestLogic : logic = true 

    # `return` will directly end Countdown_WithReturn()
    Countdown_WithReturn()<suspends>:void=
        Print ("Countdown_WithReturn Start")
        loop:
            Sleep (3.0)
            if (TestLogic?):
                Print ("Countdown_WithReturn TestLogic = true")
                return
            else:
                Print ("Countdown_WithReturn TestLogic = false")
        #Print ("This will never be executed")     # Try uncommenting this Print, the code will report an error
            
    # `break` exits the scope of the loop, and will execute the code after it
    Countdown_WithBreak()<suspends>:void=
        Print ("Countdown_WithBreak Start")
        loop:
            Sleep (3.0)
            if (TestLogic?):
                Print ("Countdown_WithBreak TestLogic = true")
                break
            else:
                Print ("Countdown_WithBreak TestLogic = false")        
        Print ("I get printed after the Countdown_WithBreak break!")


# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# Timer Evolution Challenge!
#   - Try to add pause and resume functionality to the timer
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 32 – Enum
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn to use Enum (enumeration) to create a set of named constants, to replace "magic numbers", making the code safer and more readable.

# Enum (enumeration) allows us to create a new, custom type and explicitly list all its possible values.
# Syntax: `EnumName := enum{Value1, Value2, Value3...}`
# Conventionally, I add an "E" prefix to the Enum's name for easy identification.
# Note: Enums are usually defined at the top level of a file (global scope).
EPlayState := enum{Stop, Play, Pause}

# bites_enum Continuous playback, single playback
bites_enum := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
            
    # --------------------------------------------------------------------------
    # Example 1: Magic Numbers
    # --------------------------------------------------------------------------
    # Problem: When something has multiple states (e.g., Stop, Play, Pause), the `logic` type's `true`/`false` is not enough.
    # The old "bad" method: Use integers to represent different states, for example, 0=Stop, 1=Play, 2=Pause.
    # These numbers, which have no clear meaning and whose significance is only known to the programmer, are called "Magic Numbers".
    # They are a breeding ground for bugs because they are easy to misremember or mistype, and reading the code is like "solving a puzzle".

    # State variable: 0=Stop, 1=Play, 2=Pause. Without this comment, who could understand the code?
    var Timer_A_State : int = 0
    var Timer_A : float = 0.0         
    Timer_A_Max : float = 7.0         

    # Timer A
    CountDown_A()<suspends>:void=
        Print ("Timer A starts counting")
        loop:    
            # Check if Stop              
            if (Timer_A_State = 0) { break }  
            # Timer  
            Sleep (1.0)  
            # Check if Pause
            if (Timer_A_State <> 2):  
                # If not Pause
                set Timer_A += 1.0          
                Print ("Timer_A = {Timer_A}")  
                # Loop reset check
                if (Timer_A >= Timer_A_Max ): 
                    set Timer_A = 0.0

    # Without the comments below, you would be unable to identify what state the numbers correspond to.
    OnBTN_1(Agent:agent):void =
        if (Timer_A_State = 0):        # 0=Stop
            set Timer_A_State = 1      # 1=Play
            spawn { CountDown_A() }

        else if (Timer_A_State = 1):   # 1=Play
            set Timer_A_State = 2      # 2=Pause

        else if (Timer_A_State = 2):   # 2=Pause
            set Timer_A_State = 1      # 1=Play


    # --------------------------------------------------------------------------
    # Example 2: Enum
    # --------------------------------------------------------------------------

    # `EPlayState` is now a custom 【type】, just like `int` and `logic`.
    # Its value can only be one of `EPlayState.Stop`, `EPlayState.Play`, or `EPlayState.Pause`.
    var Timer_B_State : EPlayState = EPlayState.Stop  
    var Timer_B : float = 0.0         
    Timer_B_Max : float = 7.0    

    # Timer B, take a look, the readability is greatly improved!
    CountDown_B()<suspends>:void=
        loop:
            # Check if Stop    
            if (Timer_B_State = EPlayState.Stop) { break }  
            # Timer    
            Sleep (1.0)
            # Check if Pause
            if (Timer_B_State <> EPlayState.Pause):  
                # If not Pause
                set Timer_B += 1.0          
                Print ("Timer_B = {Timer_B}")  
                # Loop reset check
                if (Timer_B >= Timer_B_Max ): 
                    set Timer_B = 0.0

    # Benefits of using Enum:
    # 1. 【High Readability】: `EPlayState.Play` clearly expresses the intent of "Play", without needing any comments.
    # 2. 【Good Safety】: You could never write erroneous code like `set Timer_B_State = EPlayState.Unknown`, because the compiler would immediately detect it and stop you.
    OnBTN_2(Agent:agent):void =
        if (Timer_B_State = EPlayState.Stop):
            set Timer_B_State = EPlayState.Play    
            spawn { CountDown_B() }

        else if (Timer_B_State = EPlayState.Play):
            set Timer_B_State = EPlayState.Pause

        else if (Timer_B_State = EPlayState.Pause):
            set Timer_B_State = EPlayState.Play  


    # Shared stop button for Examples 1 & 2        
    OnBTN_3(Agent:agent):void =
        set Timer_A_State = 0
        set Timer_A = 0.0  
        set Timer_B_State = EPlayState.Stop  
        set Timer_B = 0.0  


# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Create an Enum representing "game difficulty", including three levels: `Easy`, `Normal`, `Hard`.
# 2. Create a variable `CurrentDifficulty` of the Enum type you created, and set its initial value to `Normal`.
# 3. Create a button that, when pressed, prints a different welcome message based on the current value of `CurrentDifficulty`, for example:
#    - If it's `Easy`, print "Welcome to Easy mode!"
#    - If it's `Normal`, print "The challenge begins, Normal mode!"
#    - If it's `Hard`, print "Prepare to suffer, Hard mode!"
#    (Hint: Use an `if...else if...else` structure to check.)
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 33 – Player & Message
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn to distinguish between `agent` and `player`, and master using the `message` type to display dynamic text on UI devices like health bars.

# In this lesson, we will answer two common questions:
# 1. How to accurately get "who" triggered a button or a mechanism?
# 2. Why does a `string` that works with `Print()` cause an error on some UI devices?

# bites_player_and_message
bites_player_and_message := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}
    # Place two Billboard Devices in the scene
    @editable BBD_1 : billboard_device = billboard_device{}
    @editable BBD_2 : billboard_device = billboard_device{}

    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)

    # --------------------------------------------------------------------------
    # Example 1: message
    # --------------------------------------------------------------------------
    OnBTN_1(Agent:agent):void =
        # Many UI devices (like billboards, HUD message devices) do not allow the direct use of the `string` type for setting text.
            # Try removing the comment below, you will find this Device cannot directly take a String to change the result
        # BBD_1.SetText("Why can not I use String!?")

        # Alright, the system requires a new type `message`, so let's learn how to create a message
        # Please check the message creation method below, then come back and continue
        # Okay, now you can freely input any content and output it to the Billboard Device for display
        BBD_1.SetText( MsgString("Alright, rules are rules... blah blah blah.") )

    # Create a message
    # A field of type message must have the <localizes> specifier
    # This IamMessage will only display the "Send Message" text, and does not allow us to customize the message
    IamMessage<localizes>() : message = "Send Message" 

    # Extend the message
    # Just like creating input parameters for a function, we set the required `field:type` inside `()`, and then output it as the result
    MsgString<localizes>(String:string) : message = "{String}"


    # --------------------------------------------------------------------------
    # Example 2: The difference between `agent` and `player`
    # --------------------------------------------------------------------------
    # Below we will get the player and Print the player's name
    #   Recall that many UEFN devices can be triggered by devices other than players
    #   This confirms that an agent could be a player, an NPC, or another UEFN device
    #   In Verse, agent is a type, and player is also a type
    #   So we need a way to extract the player
    OnBTN_2(Agent:agent):void =
        # `player[Agent]` is a type conversion attempt. It checks if this `agent` is a `player`.
        # Because this check might fail (e.g., if the triggerer is not a player), you must use `if` to handle it safely.
        if (Player := player[Agent]):
            # Print ("Player Name = {Agent}")    # ❌ Error, as mentioned before, agent is not a player
            # Print ("Player Name = {Player}")   # ❌ Error, a special requirement for `player` is that it can only be output through the message type

            # In the first example, we could only input a string, so we need to extend the functionality of message again
            # This result will directly display the player's name
            Print ( MsgPlayerName(Player) )

            # This is a message extended with string + player + string
            Print ( MsgSPS("Player Name = ", Player, "") )
            # Print ( "Player Name = " + MsgPlayerName(Player) )    # ❌ Error, message and string are different types, so they cannot be added together

            # Similarly, we can directly use this message on the Billboard Device
            # Well done, this is the first step to making a player ranking feature!!!
            BBD_2.SetText( MsgSPS("Player Name = ", Player, "") )

    # This time we'll try swapping string for player       
    MsgPlayerName<localizes>(Player:player): message = "{Player}"

    # We extend the message again to make it convenient for us to handle combined information
    MsgSPS<localizes>(Text1:string, Player:player, Text2:string): message = "{Text1} {Player} {Text2}"

    # Shared Reset button for Examples 1 & 2
    OnBTN_3(Agent:agent):void =
        # Practical tip: Setting text with an empty message might cause the device to display its preset text from the UEFN editor.
        # BBD_1.SetText(CreateMessage(""))
        # To truly "clear" it, it's best to pass a message containing a single space.
        BBD_1.SetText( MsgString("") )
        BBD_2.SetText( MsgString(" ") )
        Print("Billboards have been cleared.")

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson Node
# ────────────────────────────────────────────────────────────────────────────

# This is a course checkpoint. If you are already familiar with the previous 33 lessons,
# then you should already be able to build many independent and useful Verse Devices.
# The next 4 lessons are about Class. Although there are only 4 lessons, I think Class will be another starting point in your learning.
# The reason my course explains Class at the end is that without the other fundamentals,
# it doesn't make much sense to spend a great deal of effort explaining Class, because it wasn't needed in the previous 33 lessons.
# So~ let's get started!



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 34 – Class(1): Building a Timer Robot
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn the core feature of Verse, `class`. Master how to design a custom class from scratch (a robot blueprint),
#       create a more powerful version through "inheritance", and finally "instantiate" and control them in the game.
# This lesson will continue the timer functionality from before, but implement it using the Class approach.
# EPlayState := enum{Stop, Play, Pause}

# --------------------------------------------------------------------------
# Chapter 1: Timer Robot V1, which we'll call `Unit-01`
# --------------------------------------------------------------------------
# `class:` vs `class(creative_device):`
# Please note, the end of this class definition does 【NOT】 have `(creative_device)`.
# This means it is not a UEFN device, but a pure, custom 【blueprint】 for logic and data.
# It cannot be dragged into the game scene, but it can be used as a "part" by other code.
bites_time_robot_base := class:
    # Step 0
    #   In this Class, we won't add @editable to call a UEFN Device for triggering.
    #   We will trigger all the timer robot's functions through other methods.

    # Step 1
    #   Establishing the class's required fields
    #   When creating a functional class, we can set required fields for its creation.
    #   In this case, we give the robot a name and ID as required fields.
    #   Noticed the difference? Required fields do not need an initial value configured, only `field:type`.
    #   So where do the values come from? Okay, don't rush, let's continue after setting them up.
    Name : string 
    ID : int

    # Step 2: Defining the robot's "internal state"
    # These are the robot's own memory and state, same as the timer variables in Lesson 31.
    var State : EPlayState = EPlayState.Stop  
    var Timer : float = 0.0         
    SleepTimer : float = 3.0  

    # Step 3: Defining the robot's functions
    #   Try uncommenting the code below, it will error immediately! You'll find that without `(creative_device)`, you can't use the `OnBegin` function.
    #   The main error is that it can't find the parent function. Okay, remember this error and ignore it for now, we'll explain it later.
    # OnBegin<override>()<suspends>:void= {}

    # Same as before, create a series of methods for the timer.
    Start():void=
        if (State = EPlayState.Stop):
            Print ("{Name} : START!") 
            set State = EPlayState.Play    
            spawn { Count() }

    Stop():void=
        set State = EPlayState.Stop
        set Timer = 0.0

    Count()<suspends>:void=
        loop:
            if (State = EPlayState.Stop) { break }        
            Sleep (SleepTimer)
            if (State = EPlayState.Stop) { break }  
            if (State <> EPlayState.Pause):  
                set Timer += SleepTimer          
                Print ("{Name} : {Timer}")  

    # OK, our robot Class is complete up to this point. Let's see what we've just done:
    #   Set the robot's required fields.
    #   Created the timer functionality and related operational functions.
    # Summary: We now have a robot Class that has a name, an ID, and a decent timer function.

# --------------------------------------------------------------------------
# Chapter 2: Robot V2, which we'll call `Unit-02`
# --------------------------------------------------------------------------
# Thinking about it, the original robot's functionality isn't enough and needs to be enhanced, but what if we want to keep the original basic functions?
# Okay, for the second robot's Class, we will base it on the design of the first robot. So we stole the blueprint of robot 1 and put it into robot 2...
# The `class(bites_time_robot_base)` syntax means that V2 inherits from V1.
# V1 is V2's 【Parent Class】, and V2 is V1's 【Child Class】.

# So, will there be any changes when designing Unit-02?
bites_time_robot_v2 := class(bites_time_robot_base):
    # Step 1
    #   You don't need to recreate the content created in Unit-01, and all its functions and methods can be used directly. This is the legendary "inheritance".

    # Name : string      # ❌ Error! A field that already exists in Unit-01 cannot be recreated.
    Nickname : string   # This means I can create things that Unit-01 doesn't have.

    <# Stop():void=      # ❌ Error! Similarly, the Stop() method has already been created in Unit-01.
        set State = EPlayState.Stop
        set Timer = 0.0 #>

    # Step 2
    # New function: Pause
    #   The child class will have all the functionalities of the parent class, and if the parent class is upgraded/modified, the child class will also be upgraded/modified.
    #   But new functionalities added in the child class cannot be used in the parent class.
    Pause():void=
        if (State = EPlayState.Stop):
        else if (State = EPlayState.Play):
            set State = EPlayState.Pause

        else if (State = EPlayState.Pause):
            set State = EPlayState.Play  

    # Step 3
    # Okay, I still think the original Stop function isn't suitable for Unit-02.
    #   What if a parent class's function is suitable for the parent and most child classes, but not for this specific child class, Unit-02?
    #   Use the <override> specifier. Note its position is after the function name, not after the `()`!
    #   Using <override>, you can refactor the code content of the function, but you cannot modify its input parameters, return parameters, or other specifiers.
    Stop<override>():void=
        Print ("{Name} : STOP")         # Unit-01 doesn't give a notification when it stops, Unit-02 improves this feature.
        set State = EPlayState.Stop
        set Timer = 0.0

    SleepTimer<override> : float = 2.0  # Unit-02 thinks Unit-01 is too slow.

    # Unit-02 design is finished.

    # Now let's look back at `OnBegin()`
    #   We finally understand the function `OnBegin<override>()<suspends>:void=`.
    #   The OnBegin() function is a method of the `creative_device` parent class.
    #   So all the `bites_xxx := class(creative_device):` we've created in the course are child classes of `creative_device`.
    #   We use OnBegin`<override>` precisely to 【rewrite】 it and insert our own starting logic!

    #   Now do you know why one of the two `OnBegin()` below is normal and the other will error?
    OnBegin()<suspends>:void= {}
    # OnBegin<override>()<suspends>:void= {}



# --------------------------------------------------------------------------
# Chapter 3: The Robot Factory - Production (Instantiation) and Control
# --------------------------------------------------------------------------
# After you finish the previous 2 Classes and build, you'll find they don't appear in the UEFN files.
# The reason is that in Verse, only a `creative_device` class will become a Device that can be used in UEFN after compilation.
# So next, we will execute Unit-01 and Unit-02 in the 3rd Class.
bites_class_1 := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}

    # # Step 1: Creating the robot's hangar
    #   Many courses will say: treat the classes of Unit-01 and Unit-02 as blueprints; they are not yet physical entities.
    #   So the job now is to produce them.
    #   First, we need to prepare a hangar. Here, we'll use Option to achieve this.
    #   Using the features of Option, we can store the robot in this hangar after it has been produced (instantiated).
    # We've created hangars for Unit-01 and Unit-02 respectively. The field's type is the class name.
    #   So when you create a class, that class also becomes a type, just like an enum.
    var oRobotNo1 : ?bites_time_robot_base = false
    var oRobotNo2 : ?bites_time_robot_v2 = false

    OnBegin<override>()<suspends>:void= 
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)

        # Step 2: We produce the robots right when the device starts.
        #   `set oRobotNo1 = option{}` is standard Option usage, you must be familiar with it. Now for something new:
        #       Here, `bites_time_robot_base{}` is set into oRobotNo1.
        #       And the required fields defined by the class are filled into `{}`. This completes the instantiation (production).
        #   This process, in professional terms, is called 【Instantiation】, and the produced entity is called an 【Object】 or an 【Instance】.
        set oRobotNo1 = option{ bites_time_robot_base{ Name := "Cortana", ID := 1 } }
        # Unit-02 has a `Nickname`, so it has one more required parameter than Unit-01.
        set oRobotNo2 = option{ bites_time_robot_v2{ Name := "Vivian", Nickname := "Vivi", ID := 2 } }
    # After OnBegin, we have finished producing 2 robots, oRobotNo1 and oRobotNo2.
    # Now we can start controlling them.

    # Step 3: Controlling the robots
    # Start both robots at the same time
    OnBTN_1(Agent:agent):void =
        if (Robot := oRobotNo1?):
            Robot.Start()
        if (Robot := oRobotNo2?):
            Robot.Start()
        
    # Pause the timer        
    OnBTN_2(Agent:agent):void =
        # if (Robot := oRobotNo1?) {Robot.Pause()}  # ❌ Error! Only Unit-02 has the pause function, so Unit-01 cannot use it.
        if (Robot := oRobotNo2?) {Robot.Pause()}

    # Stop both at the same time    
    OnBTN_3(Agent:agent):void =
        if (Robot := oRobotNo1?) {Robot.Stop()}
        if (Robot := oRobotNo2?) {Robot.Stop()}      # The overridden Stop() in Unit-02 has a Print function.

    # Tip : If you want to destroy the robot, just use `set oRobotNo1 = false` to clear the data of oRobotNo1.

    # This is a very crucial lesson that needs to be understood before proceeding to the next lessons.
    # If you encounter confusion while learning, please bring it up on Discord, and I will try to optimize the course content.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Design a `monster_base` parent class, including a required field `Name:string` and a variable `var Health:int = 100`.
# 2. Add a `TakeDamage(Amount:int):void` method to `monster_base`. When called, it should reduce `Health` and print the remaining health.
# 3. Design a `goblin` child class that inherits from `monster_base`.
# 4. In your factory (`creative_device`), instantiate a `goblin` object named "Goblin Scout".
# 5. Use a button to call the `TakeDamage(15)` method on this goblin object each time it's pressed.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 35 – Class(2): Mass Production and Automation of Robots
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn more advanced Class design patterns. We will build a "robot production line" to mass-produce robots that can "control themselves".

# In the last lesson, our factory was like a "remote control center", needing to operate each robot separately via buttons.
# In this lesson, we will upgrade the factory to an "automated assembly line", and the produced robots will have their own buttons to achieve "self-control".
# This design, where each part has its own responsibility, is a core idea for building large, maintainable projects.

# --------------------------------------------------------------------------
# Chapter 1: Robot V3, hereafter referred to as Unit-03
# --------------------------------------------------------------------------
# First, let's design the blueprint for the V3 robot.
# Note: We are again inheriting from `bites_time_robot_base` (V1), not V2.
# This is because we don't want V2's `Nickname` feature, but this also means V3 won't have V2's `Pause` skill.
# So, both Unit-02 and Unit-03 share the same parent class, but they each develop different functionalities.
bites_time_robot_v3 := class(bites_time_robot_base):
    # Step 1: Design "external interfaces" for the robot
    # In Unit-03, we use @editable to use UEFN's Button Device.
    # But because this class is not a creative_device, we cannot operate it directly in the editor.
    # So, we only define "slots" (variables) here, and the buttons will be "plugged in" when the factory produces them.
    # Note: These fields must be `var` because their values need to be set externally 【after】 the robot is created.
    @editable var BTN : button_device = button_device{}
    @editable var BTN_Stop : button_device = button_device{}

    # Step 2: Design the robot's "boot-up sequence" (Init)
    # V3 doesn't have `OnBegin`, so we create a custom initialization function `Init()`.
    # This function will be called by the factory after the robot is fully assembled to "activate" its functions.
    Init():void=
        BTN.InteractedWithEvent.Subscribe(OnBTN)
        BTN_Stop.InteractedWithEvent.Subscribe(OnBTN_Stop)

    # Step 3: Internal logic - the robot responds to its own button events
    OnBTN(Agent:agent):void =
        Start()

    OnBTN_Stop(Agent:agent):void =
        Stop()

    # Unit-03 is complete!


# --------------------------------------------------------------------------
# Chapter 2: The Automated Production Line - `bites_class_2`
# --------------------------------------------------------------------------
# This is our new factory, responsible for mass-producing V3 robots.
bites_class_2 := class(creative_device):
    # We get the Button part through the factory, and use the Array method to get Buttons in bulk.
    @editable BTNs_Play : []button_device = array{}
    @editable BTN_Stop : button_device = button_device{}     # All robots share one stop button

    # In the last lesson, we used Option for the robot's hangar.
    #   Here, we directly use an Array to meet the bulk demand.
    var RobotBOX : []bites_time_robot_v3 = array{}
    # During the robot instantiation process, a name needs to be provided. To achieve mass production, we first need to create a name list.
    NameList : []string = array{"Seed","Cortana","Vivian"}

    OnBegin<override>()<suspends>:void=
        # Alright, let's start mass production now.
        for (Index := 0..2):
            # The first step is to get the Button and name in order according to the Index.
            if (BTN_Play := BTNs_Play[Index], Name := NameList[Index]):
                # Then, during the production phase, output the name and ID(Index) in bulk.
                set RobotBOX += array{ bites_time_robot_v3{ Name := Name, ID := Index } }
                # Finally, we need to set the external parameters for the robot.
                if (Robot := RobotBOX[Index]):    # After the robot instance is generated, get the robot's instance from the hangar.
                    # "Plug in" the buttons from the assembly line into the new robot's corresponding slots. This process is also called "dependency injection".
                    set Robot.BTN = BTN_Play        # Configure the factory's Button for the robot.
                    set Robot.BTN_Stop = BTN_Stop  
                    # Power on and activate: call the robot's `Init()` program to make it start listening to its button events.
                    Robot.Init()  
        # Robot production and initialization complete!
    
    # Have you noticed! Now the factory's Verse Device is only responsible for the production work.
    # The execution logic after production is handled entirely by each robot itself.
    # Once production is complete, the factory's job is done. All subsequent operations (clicking buttons, timing, etc.) are performed 【independently】 by each robot.
    # This is "separation of concerns", a very powerful and clean design pattern.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# Monster Turret Automation Challenge!
# 1. Continue with the `monster_base` class from the last lesson.
# 2. Create a `turret := class(monster_base)` child class with the following new members:
#    - `@editable var MyTrigger : trigger_device = trigger_device{}`
#    - `Init():void`
#    - `OnTriggered(Agent:?agent):void`
# 3. In `Init()`, subscribe `MyTrigger`'s `TriggeredEvent` to the `OnTriggered` method.
# 4. In the `OnTriggered` method, call the `TakeDamage(25)` method inherited from the parent class.
# 5. In your factory device, prepare an array of `trigger_device`s.
# 6. In `OnBegin`, use a `for` loop to mass-produce 3 `turret` objects, assign a different trigger to each turret, and call their `Init()` methods.
# 7. Test in-game: does walking into each different trigger area only damage the corresponding turret?
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 36 – Class(3): Building Device Systems and Communication
# ────────────────────────────────────────────────────────────────────────────
# Goal: 
# 1. Use Class to create structured, flexibly configurable 【custom detail menus】 in the UEFN editor.
# 2. Implement 【one-way communication】 between multiple Verse devices, building a "central console" to manage multiple "robots".

# --- Preparation: Defining Data ---
# This is an Enum for a list of items
ERobotItem := enum{Pizza, Burger, FrenchFries, Cola, ChickenNuggets}

# We need to print the names of the Items, so we create a Map to handle the string mapping for the enum.
RobotItemText : [ERobotItem]string = map{
    ERobotItem.Pizza => "Pizza",
    ERobotItem.Burger => "Burger",
    ERobotItem.FrenchFries => "FrenchFries",
    ERobotItem.Cola => "Cola",
    ERobotItem.ChickenNuggets => "ChickenNuggets"
    }

# --------------------------------------------------------------------------
# Chapter 1: Designing "Configurable Parts" - Data Classes
# --------------------------------------------------------------------------
# First, let's design two Classes purely for "storing data". They will become the configurable components of the robot.

# `<concrete>` specifier:
#   You can think of this as putting a "ready to use (can be directly instantiated)" label on this Class.
#   In reality, not adding <concrete> won't cause an error in most cases, but it's recommended to develop good habits.

# Part 1: Robot Bag
robot_bag := class<concrete>:
    @editable Item : ERobotItem = ERobotItem.Pizza
    @editable Quantity : int = 1

# Part 2: Robot Other Settings
robot_other_setting := class<concrete>:
    @editable LoveItem : ERobotItem = ERobotItem.Pizza
    @editable Jump : logic = false

# The class below has no function in the lesson, it's just for explanation.
robot_test_class := class:       # If <concrete> is added to this Class, it will cause an error.
    Player : player
    Value : int
    # Think: Why can't the class below have `<concrete>` added?
    # Because it has required fields `Player` and `Value`, such classes often cannot be initialized when creating a field.


# --------------------------------------------------------------------------
# Chapter 2: Assembling a "Highly Configurable" Robot Device
# --------------------------------------------------------------------------
# This time, our robot itself is a `creative_device`.
bites_class_3_robot := class(creative_device):
    @editable Name : string = ""             # We edit the robot's name directly on the Verse Device.
    # Key Point: We are using the "data classes" we designed earlier as the type for our @editable fields!
    @editable Bags : []robot_bag = array{}             # We'll handle robot_bag as an Array.
    @editable Other : robot_other_setting = robot_other_setting{}   # robot_other_setting is called directly.
    @editable BTN_SubPower : button_device = button_device{}

    # The field below cannot be created because you cannot provide a valid player parameter at compile time.
    # @editable Test : robot_test_class = robot_test_class{ Value := 1, Player := ??? }

    var Battery : int = 0   # We give the robot a battery level.

    OnBegin<override>()<suspends>:void=
        set Battery = 100   # Charge the battery to 100 on initialization.
        BTN_SubPower.InteractedWithEvent.Subscribe(OnBTN_SubPower)
        Print ("{Name} Ready!")

    # Each time the button is pressed, the robot's battery level decreases by 10.
    OnBTN_SubPower(Agent:agent):void=
        set Battery -= 10  
        Print ("{Name} at work... Battery remaining: {Battery}")

    # The basic configuration of the robot is complete. Now go test and observe the results:
    #   Check the menu result of @editable Bags in UEFN.
    #       - You can add multiple different bags for the robot, with different Items and quantities.
    #   Check the menu result of @editable Other in UEFN.
    #       - You will get a collapsible submenu, which is particularly useful when dealing with complex or large requirements.
    # Place 3 `bites_class_3_robot` Devices in the UEFN scene, give each robot a different name, Bag items and quantities, and their own separate buttons.

    # Launch Session and check the results!
    #   After the game starts, each robot prints its own name, indicating it's ready.
    #   Press the corresponding button, and the robot's battery level decreases.



# --------------------------------------------------------------------------
# Chapter 3: Building a "Central Console" - Communication Between Devices
# --------------------------------------------------------------------------
# Now that we have 3 independently operating robots, we will build a "console" to manage them centrally.
bites_class_3_hub := class(creative_device):
    # Here, we directly use @editable with the `bites_class_3_robot` class.
    #   Now, `bites_class_3_robot` is a Device type, just like a Button Device.
    #   This is like linking a regular button device. We've created an Array slot for a "robot list".
    @editable Robots : []bites_class_3_robot = array{}

    @editable BTN_CheckRobots : button_device = button_device{}
    @editable BTN_ChargingAll : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        BTN_CheckRobots.InteractedWithEvent.Subscribe(OnBTN_CheckRobots)
        BTN_ChargingAll.InteractedWithEvent.Subscribe(OnBTN_ChargingAll)

    # Create a function to handle the result of the RobotItemText Map to optimize code readability and reusability.
    GetItemText(Item:ERobotItem):string=
        if (ItemText := RobotItemText[Item]):
            return ItemText
        return "ERROR!"  

    # Check the status of all robots
    OnBTN_CheckRobots(Agent:agent):void=
        Print("--- Console: Initiating system-wide status check ---")
        # Use a for loop to get each robot, then print their individual data information.
        for (Robot : Robots):
            Print ("Name : {Robot.Name}, Battery : {Robot.Battery}")
            # Here we use a second-level for loop to process all the Bags and their contents on the robot.
            for (Bag : Robot.Bags):
                Print ("Item : { GetItemText( Bag.Item ) }, Quantity = {Bag.Quantity}")

    # Charge all robots at once
    OnBTN_ChargingAll(Agent:agent):void=
        for (Robot : Robots):  
            set Robot.Battery = 100      
        Print ("--- Console: All robots have been fully charged! ---")

    # Done, now place the bites_class_3_hub in the scene.
    #   In the HUB's detail menu, add all the robots to the `Robots` item.
    #   Configure the 2 buttons.
    # Launch Session and check the results!
    #   Feel free to let the robots consume power, then use the HUB to check the status of all robots at once, or to charge them.

    # ⚠️ Important Tip!
    # Our architecture is: `HUB -> Manages -> Multiple Robots`, which is a clear 【one-way】 relationship.
    # Please 【absolutely avoid】 referencing `bites_class_3_hub` from within `bites_class_3_robot`.
    # Mutual referencing between devices can lead to a "you're in me, I'm in you" mess, which is a common source of bugs in large projects.
    #   So, what do we do when we really need to implement two-way or multi-way communication? In the next lesson, we will introduce the Event method.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Add a new button `BTN_FindPizzaLovers` to `bites_class_3_hub`.
# 2. When this button is pressed, iterate through all `Robots`.
# 3. Check if each robot's `Other` setting's `LoveItem` is `ERobotItem.Pizza`.
# 4. If it is, print that robot's name, for example: "Report! Robot {Robot.Name} is a pizza lover!"
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 37 – Class(4) Event & Await : The Ultimate Communication Solution Between Devices
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn to use `event` and `Await` to create a custom "publish-subscribe" system, enabling safe, flexible, and scalable two-way or multi-way communication between devices.

# In the last lesson, we implemented 【one-way】 communication from "Console -> Robot".
# But if a robot needs to actively "report" information to the console, or if devices need to communicate freely among themselves, the `event` mechanism is required.

# --------------------------------------------------------------------------
# Chapter 1: The Root of the Problem - The Limitations of `.Subscribe`
# --------------------------------------------------------------------------
# Below is a classic case for a Verse beginner. You will find that whether we call the Button Device directly or through a Class method,
#   `bites_class_4_hub_a` can never know which Button in the Array index was triggered.
#   This is because the `.Subscribe` method does not support returning information from an Array.
bites_class_4_button_a := class<concrete>:      
    @editable BTN : button_device = button_device{}
    var ID : int = 0

    Init():void=
        BTN.InteractedWithEvent.Subscribe(DoorOpen)

    DoorOpen(Agent:agent):void=
        Print ("B {ID}号门开启了")
        # Due to the one-way communication, we can know which door opened here, but the information cannot be passed to the HUB.

bites_class_4_hub_a := class(creative_device):
    @editable BTNs : []button_device = array{}
    @editable Doors : []bites_class_4_button_a = array{}

    OnBegin<override>()<suspends>:void=
        for (BTN : BTNs):
            # We subscribe all the buttons in the array to the 【same】 response function `OnBTN`.
            BTN.InteractedWithEvent.Subscribe(OnBTN)

        for (Index -> Door : Doors):
            set Door.ID = Index
            # ⚠️ This method is for the HUB to subscribe to the buttons within Doors.
            #   But the result is the same, it can only be assigned to the same response function `OnDoorsOpen`.
            Door.BTN.InteractedWithEvent.Subscribe(OnDoorsOpen)

    OnBTN(Agent:agent):void=
        Print ("Device BTN : Which door opened???")

    OnDoorsOpen(Agent:agent):void=
        Print ("Class BTN : Which door opened???")
        # It's impossible to know which door was opened, so the `DoorState` cannot be used to record the state at this time.


# --------------------------------------------------------------------------
# Chapter 2: Event & Await
# --------------------------------------------------------------------------
# Event Side : Child Device
#   Note that in this case, the buttons Class is a child of `creative_device`.
#   Since bites_class_4_b_buttons is a child device of the Hub,
#   we need to extend it with Event and the functionality to trigger the Event to notify the parent device.
bites_class_4_b_buttons := class(creative_device):       
    @editable BTN : button_device = button_device{}
    @editable Gold : int = 0

    # Create an Event
    #   Event syntax : `EventName`:`event(DataType)`=`event(DataType){}`
    DoorOpenEvent_A : event() = event(){}                 # A simple signal without any information
    DoorOpenEvent_B : event(int) = event(int){}           # A signal carrying an integer (e.g., amount of gold)
    DoorOpenEvent_C : event(tuple(agent,int)) = event(tuple(agent,int)){}   # A complex signal carrying an agent and gold

    var ID : int = 0    # We'll let the Hub handle this ID to avoid duplicate IDs when editing externally with @editable.

    OnBegin<override>()<suspends>:void=
        BTN.InteractedWithEvent.Subscribe(OnDoorOpen)

    OnDoorOpen(Agent:agent):void=
        # Syntax for triggering an event : `EventName`.`Signal()`
        #   If the created Event has parameters, the `()` of Signal() must also be filled with the required parameters.
        DoorOpenEvent_A.Signal()
        DoorOpenEvent_C.Signal(Agent, Gold)

# Await Side : Hub 
#   You can understand this process as manually creating a `.Subscribe` method.
#   Now we will create a custom subscription function for the Hub.
bites_class_4_b_hub := class(creative_device):
    @editable Doors : []bites_class_4_b_buttons = array{}
    var DoorState : []logic = array{}   # Used to record the state of each door

    OnBegin<override>()<suspends>:void=
        for (Index -> Door : Doors):
            set DoorState += array{false}       # Create a corresponding state list based on the number of buttons.
            set Door.ID = Index                 # Set an ID for each device.
            # Next is the custom Subscribe method.
            #   We create a separate, independent thread for each Door to handle the trigger result.
            #   They are split into A and B to correspond to the 2 Events in the Doors Class.
            spawn { OnDoorOpen_1(Index) }
            spawn { OnDoorOpen_2(Index) }

    # The independent subscription thread
    OnDoorOpen_1(ID:int)<suspends>:void=
        # The first action is a key point.
        #   Observe the relationship between `Index` in the `OnBegin`'s `for` loop and `DoorOpenEvent_A(ID:int)`.
        #   After the independent thread executes, we directly get which `Door` in `Doors` this thread needs to handle.
        if (Door := Doors[ID]):
            # We start the loop only after getting the target Door.
            #   So in the subsequent process, `if (Door := Doors[ID]):` does not need to be processed again.
            #   If your event is a one-time thing, then you might not need to use a loop.
            loop:
                # As mentioned in previous lessons, a loop must be paired with break, otherwise it will cause an error.
                #   But when a loop contains a pausing function, it might not need to be paired with a break, for example, Sleep and Await().
                # The method to call Await() is `EventName`+`.Await()`.
                #   When the code reaches `.Await()`, it will stop and wait for the event's `.Signal()` to be triggered.
                Door.DoorOpenEvent_A.Await()
                # The code below will only be executed after `.Signal()` has been triggered.
                Print ("{ID}号门开启了!")
                SetDoorState(ID, true)

    # The second subscription case demonstrates handling an Event with parameters.          
    OnDoorOpen_2(ID:int)<suspends>:void=
        if (Door := Doors[ID]):
            loop:
                # We are returning a Tuple in DoorOpenEvent_C.
                #   An expression like the one below will also pause because of `Await()`, and at the same time get the parameters passed by the Event.
                Tuple := Door.DoorOpenEvent_C.Await()
                Agent := Tuple(0)
                Gold := Tuple(1)
                # This way, we can centrally get the child device's Event in the Hub to handle advanced management needs.
                if (Player := player[Agent]):
                    Print (MsgSPS("Player ",Player," 开启了 {ID} 号门，并获得了 {Gold} Gold"))
                    SetDoorState(ID, true)

    SetDoorState(ID:int, State:logic):void=
        if (set DoorState[ID] = State) {}

    MsgSPS<localizes>(Text1:string, Player:player, Text2:string): message = "{Text1} {Player} {Text2}"

    # Done, place the Devices, then Launch Session to see the results!

    # ⚠️ Architecture Considerations and Notes
    # This lesson demonstrates an Event solution for parent-child level hierarchies, but! This is not applicable for handling communication between parent-level to parent-level.
    # So when the system becomes more complex, you can even establish a global "information center" where all devices communicate only with this center, achieving complete decoupling.


# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# Continuing the monster/turret challenge from the last lesson:
# 1. In the `turret` class, create a new `event`: `DestroyedEvent : event(string) = event(string){}`.
# 2. Modify the `TakeDamage` method: when the turret's `Health` drops to 0 or below, `Signal` its `DestroyedEvent`, and broadcast its own `Name` as data.
# 3. In your "factory" device (`bites_class_2`), `spawn` an independent listening process for 【each】 produced turret.
# 4. This listening process needs to `Await` the corresponding turret's `DestroyedEvent`. When it receives a signal (i.e., the turret is destroyed), print a message,
#    for example: "Report to command center: Turret '{received_name}' has been destroyed!"
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 38 – Struct
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn the `struct` type, understand its differences from `tuple` and `class`, and master how to use it to create clear, maintainable data structures.

# `struct` is very similar to `Tuple`, but its usage is more rigorous: 
#   - `Tuple` (元组):   Most lightweight. Like a temporary "data parcel" used to bundle a few values for transmission. Accessed by index `(0)`, lacks readability.
#   - `Struct` (结构体): The data specialist. Like an "information registration form", where each field has a clear name. Accessed by name `.Name`, clear and easy to read.

# Conclusion: When you need a pure, structurally clear "data container", `struct` is the best choice.
# Syntax for creating a struct : `StructName`:=`struct{ FieldName1:Type1, FieldName2:Type2, More... }`
# Note: `struct`, like `enum`, must be created in the global scope.
# Now we use a struct to design the robot in a more structured way
RobotStruct := struct{
    State:logic, 
    Name:string,
    Battery:float,
    BagCapacity:int
    }

# --------------------------------------------------------------------------
# Chapter 1: Struct vs. Tuple - Data Definition Comparison
# --------------------------------------------------------------------------
# We create a "database" class to define the same data in two ways.
bites_robot_data := class<concrete>:
    
    # Method One: Creating data using Tuple
    # tuple(Name, Battery, BagCapacity)
    List_T : []tuple(string,float,int) = array{
        ("Seed"     , 200.0, 3),
        ("Cortana"  , 160.0, 4),
        ("Vivian"   , 130.0, 8)
        }

    # Method Two: Creating data using struct
    #   The `RobotStruct` used here is the struct created in the global scope earlier.
    List_S : []RobotStruct = array{
        # Creating data for a struct
        #   `StructName{ FieldName1 := Value1, FieldName2 := Value2, More...}`
        RobotStruct{State := false, Name := "Seed"   , Battery := 200.0, BagCapacity := 3},
        RobotStruct{State := false, Name := "Cortana", Battery := 160.0, BagCapacity := 4},
        RobotStruct{State := false, Name := "Vivian" , Battery := 130.0, BagCapacity := 8}
        }

# --------------------------------------------------------------------------
# Chapter 2: Usage and Modification of Struct
# --------------------------------------------------------------------------
bites_struct := class(creative_device):
    # Instantiate `bites_robot_data` in order to call its data
    RobotData : bites_robot_data = bites_robot_data{}

    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}
    
    # This array is used to demonstrate getting, storing, and modifying structs
    var Robots : []RobotStruct = array{}

    # Print the robot's struct information
    PrintRobotsState():void =        
        for (Robot : Robots):
            # Extracting information from a struct is very simple, just enter the `.FieldName` you want to extract.
            #   You'll find that extracting information from a struct is more convenient than from a Map, and clearer than from a Tuple.
            Print ("{Robot.Name}, Battery={Robot.Battery}, BagCapacity={Robot.BagCapacity}")

    # Below we use 2 methods to get data from RobotData to build the individual struct data within Robots.
    # This case uses Tuple's Data
    InitRobots_T():void=
        for (DataTuple : RobotData.List_T):
            CreateRobotData := RobotStruct{
                                 State := false,     # Since State was not designed in DataTuple, we directly give it a false here 
                                 Name := DataTuple(0),
                                 Battery := DataTuple(1),
                                 BagCapacity := DataTuple(2) }
            set Robots += array{ CreateRobotData }    

    # This case uses Struct's Data
    InitRobots_S():void=
        for (DataStruct : RobotData.List_S):
            set Robots += array{ DataStruct }   
        # This shows the Struct method is simpler and more efficient than the Tuple method, but only when the incoming data remains consistent.

    # OnBegin        
    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
        InitRobots_S()       # Here we use `InitRobots_S()` for the demonstration
        PrintRobotsState()   

    # This case demonstrates modifying the content of the first Robot's data.
    OnBTN_1(Agent:agent):void =
        # Note! This is where mistakes are easily made! You might handle it like this: ❌ `if (set Robot = RobotStruct{...`
        #   The purpose of getting `Robot` here is to prepare for `Name := Robot.Name` in the struct.
        if (Robot := Robots[0]):
            if (set Robots[0] = RobotStruct{
                    # The process of handling a struct must be consistent with the original structure.
                    #   Try deleting any of the State, Name, or Battery content, and an error will occur.
                    State := true,
                    # If you want some parameters to remain unchanged, then directly get the original value and fill it in.
                    Name := Robot.Name, 
                    Battery := 500.0,
                    BagCapacity := 10 } ):
        PrintRobotsState()

    # This case modifies all Robot data uniformly.
    OnBTN_2(Agent:agent):void =
        <# This is the same error as noted above. The correct way to modify an Array is `if (set ArrayName[Index] = NewValue){}`
        for (Robot : Robots):    
            if (set Robot = RobotStruct{    # ❌ 
        #>  

        for (Index -> Robot : Robots):
            if (set Robots[Index] = RobotStruct{
                                     State := true,
                                     Name := Robot.Name,
                                     Battery := 300.0,
                                     BagCapacity := 3 } ):
        PrintRobotsState()

    # Reset All data    
    OnBTN_3(Agent:agent):void =
        # Did you notice! Unlike InitRobots_S(), this is a simpler and more direct method!
        set Robots = RobotData.List_S 
        PrintRobotsState()   

# You can also use the following 2 ways to construct robots and data      
<#
# Instantiate a robot, suitable for methods generated by creative_prop
bites_struct_robot_a := class:
    RobotData : RobotStruct

# Device robot, suitable for robots built directly in the scene
bites_struct_robot_b := class(creative_device):
    var RobotData : RobotStruct = RobotStruct{State := false, Name := "" , Battery := 0.0, BagCapacity := 0}
#>
    
# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Create a Struct named `WeaponStat` that includes the fields `Name:string`, `Damage:float`, `Ammo:int`.
# 2. In your device, create an array of `WeaponStat`: `var MyWeapons : []WeaponStat`.
# 3. When the game starts, add data for at least two weapons to the `MyWeapons` array.
# 4. Create a button that, when pressed, can increase the `Damage` of the 【first】 weapon in your arsenal by 10 points and refill its `Ammo` to 100.
# 5. After each modification, iterate through and print the status of all your weapons to confirm the modification was successful.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 39 – Common Issues
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn to identify and solve several of the most common beginner errors in Verse programming and the UEFN workflow, clearing obstacles for your future programming journey.
# This lesson does not teach new features but imparts experience. Mastering these will save you a great deal of valuable debugging time!

# bites_i_am_class
bites_i_am_class := class:
    block:

# bites_common_errors
bites_common_errors := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)

    # --------------------------------------------------------------------------
    # (1) Problem: I wrote a function, but it just won't execute, and there's no error!
    # --------------------------------------------------------------------------
    # 💡 Reason:
    #   This is a classic beginner's problem, because you didn't add `()`. Please observe the result of OnBTN_1 below.
    #   Although it's not formal, an easy way to understand and remember this initially is:
    #       - A Field has no suffix symbol.
    #       - A Function has the suffix symbol ().
    #       - A Class has the suffix symbol {}.

    # bites_i_am_class is a Class, its suffix symbol is {}
    IamClass : bites_i_am_class = bites_i_am_class{}

    # IamField is a Field, it has no suffix symbol.
    IamField : string = "IamField"

    IamFunctionA():void = { Print ("Iam Function A & " + IamField) }
    IamFunctionB():void = { Print ("Iam Function B & " + IamField) }
    IamFunctionC(Value:int):void = { Print ("Iam Function C & " + IamField) }
        
    OnBTN_1(Agent:agent):void =
        Print("--- Starting function call test ---")
        IamFunctionA    # ❌ Error, but no error is reported, and it won't be executed.
        IamFunctionB()  # ✅ Will be executed, IamFunctionB is a Function, its suffix symbol is ().
        IamFunctionC    # ❌ Verification: adding `()` will cause an error, not adding it won't, but it also won't execute.
        
    # --------------------------------------------------------------------------
    # (2) Problem: I entered special characters, like quotes, in my string, and it messed up my code!
    # --------------------------------------------------------------------------
    # 💡 Reason:
    #   A string is wrapped in a pair of double quotes `""`. If you use `"` or `'` directly in the middle, the compiler will mistakenly think the string ends there, leading to syntax confusion.
    #
    # ✅ Solution:
    #   Before the special character you want to input, add a backslash `\`. This is called an "escape character", and it tells the compiler: "This symbol is part of my content, not syntax."

    OnBTN_2(Agent:agent):void =
        Print("--- Starting escape character test ---")
        # Print("He said: "Hello!"") # ❌ Error: The middle double quotes will "break" the string structure.
        Print("He said: \"Hello!\"") # ✅ Correct: Use `\"` to insert double quotes inside a string.

        # Print("I'm learning Verse") # ❌ Error: Single quotes can also sometimes cause issues (especially in the message type).
        Print("I\'m learning Verse") # ✅ Correct: Use `\'` to safely insert a single quote.
        
        # Other common escapes: `\\` to insert a backslash itself, `\n` for a new line.
        Print("File path: C:\\Users\\MyFolder\nThis is a new line.")

    # --------------------------------------------------------------------------
    # (3) Workflow Problem: I changed the name of my Verse device class, and then UEFN broke!
    # --------------------------------------------------------------------------
    # This is an extremely important and dangerous operation, please read it carefully!
    #
    # 🤔 Problem:
    #   In your Verse file, you changed the name of a `class(creative_device):`, for example, from `my_device_v1` to `my_device_v2`.
    #   At this time, you already have several instances of `my_device_v1` placed in your UEFN scene.
    #
    # 💥 Consequence:
    #   After clicking "Build Verse Code", UEFN will pop up a 【Verse Validation Errors】 error!
    #   This is because: device instances in the scene identify their blueprint by the 【class name】. You changed the blueprint's name, so the old device instances have become "orphans" and can't find their home.
    #
    # ✅ Solution and Risk Warning:
    #   The pop-up window has two options: 【Rebuild】 and 【Continue】.
    #
    #   1.  **【Rebuild】(Safe Option)**:
    #       - **When to use**: When you realize you made a mistake and want to undo the change.
    #       - **Action**:
    #         1.  **Do not** click the 【Rebuild】 button yet.
    #         2.  First, go back to the Verse file and 【change the class name back to the original name】.
    #         3.  Save the file, then go back to UEFN and click 【Rebuild】.
    #       - **Result**: Everything returns to normal, and the devices and their parameters in the scene will not be lost.
    #
    #   2.  **【Continue】(High-Risk Option)**:
    #       - **When to use**: When you are 【certain】 you want to abandon all old device instances and use the new class name.
    #       - **Action**: Click 【Continue】 directly.
    #       - **Result**:
    #         - UEFN will accept your new class name and compile a new device.
    #         - All old device instances in the scene will become 【permanently invalid】, and all their configured parameters will be lost! You must delete them manually and drag the new device into the scene again.
    #         - ⚠️ **Ultimate Warning**: In some cases, clicking 【Continue】 can lead to a catastrophic bug—**【all】 Verse device configuration parameters in the scene are reset to their initial state!**
    #
    #   **The Golden Rule: Before performing major surgery like renaming a `creative_device` class, you must, absolutely, positively make a 【project backup】 first!**


# ─────────────────────────────────────────────────────────────────────────────
# Friends, if you have encountered any other problems that we have not mentioned in this course,
# you are welcome to give me feedback on Discord. I will update it in this course to help more friends.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 40 – Common Features
# ────────────────────────────────────────────────────────────────────────────
# This is the last lesson of the basic course. We will learn about `using` and other common functionalities.

# --------------------------------------------------------------------------
# `using` : Importing "Function Modules"
# --------------------------------------------------------------------------
#   From Lesson 01-39, we have been consistently using 2 API modules:
#       - using { /Fortnite.com/Devices }
#       - using { /Verse.org/Simulation }
#   These 2 modules are the most basic functionalities of Verse, so for the entire basic course, we only needed them.
#   When we start formal development, we will need some features that are not in the basic modules. This is when we need to add references to new modules.
#   Besides calling referenced API modules, `using` is also used for referencing project folders and assets.

# Below we `using` a few modules that will be needed for the course.
using { /Verse.org/Random }                       # Reference when random number functionality is needed
using { /Fortnite.com/Characters }                # Reference when getting the player's character
using { /Fortnite.com/Game }                      # Provides game state-related functionalities
using { /UnrealEngine.com/Temporary/SpatialMath } # Reference when dealing with "spatial math" (like vectors, rotation)


# --------------------------------------------------------------------------
# Graduation Challenge: Code Comprehension
# --------------------------------------------------------------------------
# Congratulations on completing the previous 39 lessons! Now, it's time to test what you've learned.
# The code below does 【not】 have many comments. Please try to infer the functionality of each piece of code based on your existing knowledge and the naming of functions and variables.
# You can also try looking up the command descriptions directly in the API.
# Learning to read code is the first step to becoming a real developer!

# bites_common_features
bites_common_features := class(creative_device):
    # This is the method to get a Creative Prop.
    #   Please place some official assets from /All/Fortnite/Props into the scene.
    #   Or use your own defined Prop blueprint (only Building Prop is supported, Building Static Mesh cannot be used).
    #   Please turn off the Prop's collision first.
    @editable Prop_1 : creative_prop = creative_prop{}
    @editable Prop_2 : creative_prop = creative_prop{}
    @editable Prop_3 : creative_prop = creative_prop{}
    @editable Prop_4 : creative_prop = creative_prop{}

    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}
    @editable BTN_4 : button_device = button_device{}
    @editable BTN_5 : button_device = button_device{}

    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
        BTN_4.InteractedWithEvent.Subscribe(OnBTN_4)
        BTN_5.InteractedWithEvent.Subscribe(OnBTN_5)
        # Get the current time
        set CurrentSeconds = GetSecondsSinceEpoch() 
        Print ("CurrentSeconds = {CurrentSeconds}")

    var CurrentSeconds : float = 0.0    

    # Random Numbers
    OnBTN_1(Agent:agent):void =
        RandomInt := GetRandomInt(3, 9)
        Print ("RandomInt = {RandomInt}")

        RandomFloat := GetRandomFloat(0.0, 1.0)
        Print ("RandomFloat = {RandomFloat}")

        set IntBOX = Shuffle(IntBOX)

        var String : string = ""
        for (Value : IntBOX):
            set String += "{Value},"
        Print ("IntBOX = " + String)

    var IntBOX : []int = array{53, 80, 9, 172, -33}    

    # Teleport Prop
    OnBTN_2(Agent:agent):void =
        Prop_2.Hide()
        Prop_3.Hide()
        if (Prop_1.TeleportTo[Prop_2.GetTransform()]){}
        spawn { MoveProp() } 

    MoveProp()<suspends>:void= 
        Sleep (3.0)
        Result := Prop_1.MoveTo(Prop_3.GetTransform(), 1.0)
        if (Result = move_to_result.DestinationReached):
            Print ("DestinationReached")
            Prop_2.Show()
            Prop_3.Show()
        else if (Result = move_to_result.WillNotReachDestination):
            Print ("WillNotReachDestination")

    # Application of Characters
    # Characters is the character controlled by the Player, which is different from the Player.
    OnBTN_3(Agent:agent):void =
        if (Player := player[Agent]):
            if (FortCharacter := Player.GetFortCharacter[]):
                FortCharacter.Hide()
                # FortCharacter.SetVulnerability(true)
                # FortCharacter.SetVulnerability(false)
                # FortCharacter.GetHealth()   # For Shield, it is GetShield
                # FortCharacter.SetHealth(200.0)
                # FortCharacter.GetMaxHealth()
                # FortCharacter.SetMaxHealth(200.0)

    # Teleport Player
    OnBTN_4(Agent:agent):void =
        if (Player := player[Agent]):
            if (FortCharacter := Player.GetFortCharacter[]):
                FortCharacter.Show()
            TeleportPlayer(Player)

    TeleportPlayer(Player:player):void =
        if (FortCharacter := Player.GetFortCharacter[]):
            TargetPos := Prop_4.GetTransform().Translation
            TargetRot := Prop_4.GetTransform().Rotation
            if ( FortCharacter.TeleportTo[Position:vector3 = TargetPos, Rotation:rotation = TargetRot] ){}
 
    # Get current time - elapsed time
    OnBTN_5(Agent:agent):void =
        AfterSeconds := GetSecondsSinceEpoch() - CurrentSeconds
        Print ("AfterSeconds = {AfterSeconds}")
 

# ─────────────────────────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════

# 🎉 Congratulations! You have completed all the basic courses! 🎉
# You now have the core skills to understand and write Verse code.
# The doors to countless advanced tutorials, official documentation, and open-source projects online are now open to you.
# The next adventure is up to you! I wish you endless possibilities in the world of Verse!

# Please continue to follow me: https://x.com/_PizzaVsBurger/
# Join the Discord for communication and interaction: discord.gg/AhU7WkUdUD
