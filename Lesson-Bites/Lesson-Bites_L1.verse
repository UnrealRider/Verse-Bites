# ═════════════════════════════════════════════════════════════════════════════
#   Verse-Bites: Level 1 (UEFN Verse Tutorial)
#   Author: UnrealRider
#   Project Homepage:   https://github.com/UnrealRider/Verse-Bites
#   Description: This Verse file contains the complete source code for the Verse-Bites Level 1 tutorial series (Lessons 00-24).
# -----------------------------------------------------------------------------
#   Copyright & License:
#   Copyright (c) 2025 UnrealRider
#   This project is licensed under the terms of the MIT License.
#   The full license text can be found at: https://github.com/UnrealRider/Verse-Bites/tree/main?tab=MIT-1-ov-file
# ═════════════════════════════════════════════════════════════════════════════

# --- Lesson Content Starts Below ---

# Lesson-Bites Level 1
# Version: beta 1.2

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }


# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 00 – Before You Begin
# ────────────────────────────────────────────────────────────────────────────
# Before starting, please complete the preparations outlined at the following URL:
# https://github.com/UnrealRider/Verse-Bites/blob/main/Lesson-Bites/README.md
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 01 – Creating Your First Verse Device
# ────────────────────────────────────────────────────────────────────────────

# bites_a_device
bites_a_device := class(creative_device):
    # Think of the `class` line above as a [blueprint] for a device.
    # `bites_a_device` is the name you give this blueprint, which you'll see later in UEFN.

    # `OnBegin` is a special [action command] that [automatically runs once] when the game starts.
    # It's like a "startup program" you set for your device.
    OnBegin<override>()<suspends>:void =
        # `Print` displays the text inside the parentheses in the top-left corner of the game screen.
        Print("Hello! This is my first Verse device!")

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Copy the entire [blueprint] into your MyBites.verse file.
# 2. Change the blueprint name `bites_a_device` to something you like, for example, `my_awesome_device`.
#    ✨ Tip: It's normal to see an error after copying! All .verse files in a project belong to the
#    same "jurisdiction," so every Class (blueprint) name must be [unique]. You [must rename] it.
# 3. Click the "Build Verse" button to have UEFN "manufacture" the device from your blueprint.
# 4. In the UEFN Content Browser, find your device and drag it into the game scene.
# 5. Start the game. Did your `Print` message appear successfully?

# Lesson 01 – 1
# Meet the bug's friend: the red squiggly line (Error)!
    # Verse has strict naming rules. Names can only use [English letters, numbers, and underscores], and [cannot start with a number].
    # Try changing the device name to `1bites_a_device` or `bites-device`. See the red squiggly line appear?
    # This line is reminding you: "This name is invalid." When you try to build, it will turn into an official error report.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 02 – Making a Device and a Button "Talk"
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Make our Verse device react when a player presses a UEFN button.
#   For this lesson, you only need a general idea of the process; you don't need to understand every detail right away.

# bites_a_button_device
bites_a_button_device := class(creative_device):

    # `@editable` adds a [configurable property] to the UEFN Details panel.
    # After building the code, we'll see this `Button` property in the Details panel, allowing us to link a Button Device.
    @editable Button : button_device = button_device{}

    # OnBegin
    OnBegin<override>()<suspends>:void =
        # `Subscribe` is a "subscription" function. It subscribes to the button's `InteractedWithEvent`.
        # Whenever a player presses the Button, `OnButtonPushed` will be executed.
        Button.InteractedWithEvent.Subscribe(OnButtonPushed)

    # This `OnButtonPushed` function runs whenever a player presses the button.
    OnButtonPushed(Agent:agent):void =
        Print ("Hey, someone pushed the button!")
    # `OnButtonPushed(Agent:agent):void =` is also a Function. You might have some questions:
        # What is `Agent:agent` here? I can tell you that `agent` represents the player who pushed the button, but before Lesson 18,
        # knowing this won't be very helpful. I suggest you don't worry about understanding it for now; just copy and paste it.
        # How do I tell the difference between a Class and a Function? Before Lesson 19, just remember that anything with `class` is a Class, and anything with `void` is a Function.


# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Copy `bites_a_button_device` into your MyBites.verse file and remember to give it a new name.
# 2. Build Verse to "manufacture" this new Verse Device, then place it in your UEFN scene.
# 3. Place a Button Device in your UEFN scene.
# 4. In the Details panel of your Verse Device, find the "Button" property and select the Button Device you just added.
# 5. Start the game, press the button, and see if your device reacts!
# ═════════════════════════════════════════════════════════════════════════════


# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 03 – Comments
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Learn the two common ways to write comments.

# bites_comments
bites_comments := class(creative_device):

    # OnBegin
    OnBegin<override>()<suspends>:void =
        # 1. Single-line comments start with `#` and go to the end of the line.
        #    Below is an example of an inline comment: using # to the right of the code for explanation.
        Print("Comments 1")   # This is an inline comment.

        # A comment on the line above the code. This comment will not affect the next line of code.
        Print("Comments 2")

        # ❌ Invalid example: writing code after a comment symbol will be treated as part of the comment.
        # Print("Comments 3")

        # 2. Block comments start with `<#` and end with `#>`, and can span multiple lines.
        #    The three lines below are enclosed in a `<# #>` block comment and will not be executed in the game.
        <#
        Print("Comments 4")
        Print("Comments 5")
        #>

        Print("Comments 6")   # In the end, you will only see lines 1, 2, and 6 in the game.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# Copy the code into MyBites.verse to test it.
# Try adding or removing comments and observe the changes in the printed output.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 04 – Creating Fields (Constants and Variables)
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn how to store data in a device and understand the difference between a "constant" and a "variable".

# bites_create_field
bites_create_field := class(creative_device):

    # In our code, we need "containers" to store numbers, text, or other data. These containers are called [Fields].
    # Fields come in two types: constants and variables.
    # The key difference between them is the `var` keyword.

    # Without `var`, this is a [constant]. Once set, it can never be changed.
    Value_1 : int = 10

    # With `var`, it becomes a [variable]. You can change its value at any time later.
    var Value_2 : int = 20
    
    # OnBegin
    OnBegin<override>()<suspends>:void =
        # set Value_1 = 100      # ❌ Compile error! Trying to change the constant Value_1 will cause the program to fail to build.
        Print("The value of the constant Value_1 is: {Value_1}")

        # Variables can be assigned a new value using the `set` expression.
        set Value_2 = 200
        Print("The modified value of the variable Value_2 is: {Value_2}")

    # Simple Summary
    # Constant: Like words [carved in stone], once set, it never changes.
    # Variable: Like words [written on a whiteboard], you can use `set` to erase and rewrite it anytime.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. In your code, add a new constant and a new variable of your own.
# 2. Try to modify them using `set` and see for yourself that the constant really does cause an error.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson Template – Create a generic template for testing in MyBites.verse
# ────────────────────────────────────────────────────────────────────────────
# This is the generic template that will be used in the upcoming lessons. Copy it into your MyBites.verse.
# You will also need to prepare 3 Button Devices in your UEFN scene.

# test_generic_template
test_generic_template := class(creative_device):

    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}

    # OnBegin
    OnBegin<override>()<suspends>:void =
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)

    # OnBTN_1
    OnBTN_1(Agent:agent):void =
        # When you haven't implemented any functionality yet, use `block:` as a placeholder to avoid errors.
        block:
            
    # OnBTN_2
    OnBTN_2(Agent:agent):void =
        block:

    # OnBTN_3
    OnBTN_3(Agent:agent):void =
        block:

# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 05 – Common Type: string
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn how to use strings to handle text and display it on the screen.

# bites_string
bites_string := class(creative_device):

    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}

    # OnBegin
    OnBegin<override>()<suspends>:void =
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
        
    # In programming, any text enclosed in [double quotes " "] is a string.
    Name : string = "Unreal Rider" 
    var Time : int = 7
    var Day : string = "AM"

    # OnBTN_1
    OnBTN_1(Agent:agent):void =
        # 1. Printing the "literal text" vs. printing the "field's content"
        Print("Name")   # This will only print the four letters N-a-m-e.
        Print(Name)     # This will read the content stored in the Name field, which is "Unreal Rider".

        # 2. [Embedding] field content within a string
        #    No matter what the field type is (string, int, float...), as long as it's wrapped in `{}`,
        #    its value will be automatically converted and inserted into the string.
        Print("Embedding Name(string) with braces: {Name}")
        Print("Embedding Time(int) with braces: {Time}")

    # OnBTN_2
    OnBTN_2(Agent:agent):void =
        # You can concatenate strings using the `+` operator.
        # Note: Only {Time} and {Day} will display the variable content, because they are wrapped in `{}`.
        Print(Name + " is learning Verse at {Time} {Day}")

    # OnBTN_3
    OnBTN_3(Agent:agent):void =
        # Modify variables with `set` and observe the result.
        set Time = 10
        set Day = "PM"
        # Print again, and you'll find the message has been updated!
        Print(Name + " is learning Verse at {Time} {Day}")

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Add your own string constant, for example, `MyName : string = "Your Name"`.
# 2. Add an integer variable, for example, `var MyScore : int = 100`.
# 3. In OnBTN_1, try to print a sentence that includes both your name and score.
#    For example: Print("{MyName}'s score is {MyScore}")
# 4. In OnBTN_2, give yourself 50 more points using `set MyScore += 50`, then print the sentence again.
#    See if the score has really increased!
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 06 – Common Types: int, float & Math
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Learn about the number types int (integer) and float (floating-point number), and how to use basic math operators `+ - * /`.
#   First, let's understand the two number types:
#   `int`  : Integers, which are numbers without a decimal point, like -10, 0, 99.
#   `float`: Floating-point numbers, which are numbers with a decimal point, like -0.5, 3.14, 100.0.

# bites_value_and_math
bites_value_and_math := class(creative_device):

    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}
    @editable BTN_Reset : button_device = button_device{}      # Add a reset button

    OnBegin<override>()<suspends>:void =
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
        BTN_Reset.InteractedWithEvent.Subscribe(OnBTN_Reset)  # Subscribe the reset button

    # Field definitions
    DefaultValue : int = 100      # This is a constant, used for presets or calculations
    var IntValue_1 : int = 100
    var FloatValue : float = 50.0

    # OnBTN_Reset: When this button is pressed, all mutable values are restored to their initial state.
    OnBTN_Reset(Agent:agent):void =
        # Direct assignment using `set`
        set IntValue_1 = DefaultValue
        set FloatValue = 50.0
        Print("--- Values have been reset ---")
        Print("Current state -> IntValue_1 = {IntValue_1}, FloatValue = {FloatValue}")

    # OnBTN_1: Learning compound assignment operators (+=, -=)
    OnBTN_1(Agent:agent):void =
        # Basic addition
        set IntValue_1 = IntValue_1 + 10
        Print ("IntValue_1 `IntValue_1 + 10` = {IntValue_1}")

        # Compound assignment (recommended)
        set IntValue_1 += 10    # Equivalent to IntValue_1 = IntValue_1 + 10
        Print ("IntValue_1 `+=10` = {IntValue_1}")

        # `+=` `-=` `*=` `/=`
        set IntValue_1 *= 2   # Multiply by 2
        Print ("IntValue_1 `*=2` = {IntValue_1}")

    # OnBTN_2: Learning order of operations and parentheses ()
    OnBTN_2(Agent:agent):void =
        # Verse follows the rule of [multiplication/division before addition/subtraction], just like in math.
        # `()` can be used to force a different order of operations; expressions inside parentheses are calculated first.
        set IntValue_1 = 2 * (DefaultValue - (25 + 45))
        Print("set IntValue_1 = 2 * (DefaultValue - (25 + 45)) = {IntValue_1}")

        # Additionally, `Print` can perform calculations inside {} and output the result.
        Print("DefaultValue - 45 = {DefaultValue - 45}")

    # OnBTN_3: Special rules for division (/)
    OnBTN_3(Agent:agent):void =
        # ⚠️ Verse is very strict about number types, especially with division!
        # set IntValue /= 10      # ❌ Example 1: Integers cannot be directly divided using `/`.
        # set FloatValue /= 20    # ❌ Example 2: A float cannot be directly divided by an integer.

        # ✅ Correct way: Ensure at least one side of the division is a float (i.e., has a decimal point).
        set FloatValue /= 20.0
        Print("FloatValue /= 20.0   → {FloatValue}")

        # So how do we divide an int? We will learn how to handle type conversions in Lesson 12.

    # ⚠️ Important
    # In Verse, a single equals sign `=` is used for [conditional checks] (e.g., if A = B).
    # The `set` keyword is used for [assignment] (e.g., set A = B).

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Create a treasure chest health variable: `var BoxHealth : int = 500`.
# 2. Modify OnBTN_Reset so it also resets `BoxHealth`.
# 3. Make BTN_1 a "light attack" that deals 75 damage to the chest (`-= 75`).
# 4. Make BTN_2 a "heavy attack" that deals 150 damage.
# 5. Make BTN_3 a "healing potion" that restores 200 health to the chest (`+= 200`).
# 6. After each action, print the chest's remaining health. Experience attacking and healing, then use the reset button to restore it to full health!
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 07 – Advanced Fields: Fields & @editable
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Learn how to use the `@editable` keyword to make your fields appear in the UEFN Details panel,
#   allowing you to modify them directly in the editor without changing code!

# bites_create_field_2
bites_create_field_2 := class(creative_device):

    # --- 1. Field Syntax Review and Definition ---
    # Let's use the line below as an example to break down the structure of a field again:
    PlayerName : string = "Hero"

    # → `PlayerName` : The [name] of the field, defined by you.
    # → `:`          : The [separator] between the name and the type.
    # → `string`     : The [data type] of the field (a string in this case).
    # → `=`          : The [assignment operator] between the type and the initial value.
    # → `"Hero"`     : The [initial value] assigned to the field.
    # Read all together, it means: "Create a field named PlayerName, its type is `:` string, and its value is `=` 'Hero'."

    # The value of this field is fixed. To change it, you must come back to the Verse file.
    BaseDamage : int = 100

    # --- 2. Fields Adjustable in the UEFN Editor ---
    # `@editable` is not just for linking UEFN Devices.
    # It also allows you to input values in the UEFN Details panel, which is convenient for level design. Doesn't it feel more like a real Device now?
    @editable PlayerTitle : string = "Shining"
    @editable WeaponBonus : int = 25

    OnBegin<override>()<suspends>:void =
        # When the game starts, we add the fixed value and the editable value together and print the result.
        TotalDamage := BaseDamage + WeaponBonus
        Print("{PlayerTitle} {PlayerName}'s total damage is: {TotalDamage}")

    # Simple Summary
    # `@editable` is the bridge between [Verse code] and the [UEFN editor].
    # It allows us to expose frequently adjusted values (like damage, health, speed, text, etc.) in the editor,
    # letting us use it as a configurable Device, ⚠️ with each instance having its own parameters to run the game.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# Try placing multiple instances of this Verse Device in the scene and configuring different parameters for each to observe the results.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 08 – Control Flow: Making Decisions with if
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Learn how to use the `if` statement to make your program execute different code based on different conditions.

# bites_if
bites_if := class(creative_device):

    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}
    @editable BTN_4 : button_device = button_device{}

    OnBegin<override>()<suspends>:void =
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
        BTN_4.InteractedWithEvent.Subscribe(OnBTN_4)

    Value_A : int = 2
    var Value_B : float = 10.0

    # OnBTN_1: Independent `if` statements
    # Think of these as a series of [separate true/false questions]. The program will check every single one.
    OnBTN_1(Agent:agent):void =
        Print("--- Starting independent if checks ---")
        if (Value_A = 1):
            Print("Question 1: Does Value_A equal 1? -> No") # ← This example will not print

        if (Value_A = 2):
            Print("Question 2: Does Value_A equal 2? -> Yes") # ← This example will print

        if (Value_A > 1):
            Print("Question 3: Is Value_A greater than 1? -> Yes") # ← This example will also print

    # OnBTN_2: `if...else`
    # Unlike the previous example, when the `if` condition is false, the code in the `else` block will be executed.
    OnBTN_2(Agent:agent):void =
        if (Value_A = 2):
            Print("if else A:: Value_A equals 2 -> true")   # ← This example will print
        else:
            Print("if else A:: Value_A equals 2 -> false")

        if (Value_A = 1):
            Print("if else B:: Value_A equals 1 -> true")
        else:
            Print("if else B:: Value_A equals 1 -> false")  # ← This example will print

    # OnBTN_3: `if...else if...else`
    # The program checks from top to bottom. Once it finds a `true` condition and executes its code, the entire structure is [immediately exited], and all subsequent parts are skipped.
    OnBTN_3(Agent:agent):void =
        if (Value_A = 10):
            Print("else if :: Value_A is 10")
        else if (Value_A > 5):
            Print("else if :: Value_A is greater than 5")
        else if (Value_A = 2):                               # ← It finds this is true, executes, and exits.
            Print("else if :: Value_A is 2")                 # Executes this and exits.
        else if (Value_A > 0):
            Print("else if :: Value_A is greater than 0")    # Although this is also true, it [will not be executed] because the previous condition was met.
        else:
            Print("None of the above conditions were met")

    # OnBTN_4: `if...then` (Multiple "AND" conditions)
    # Use this when you need [all conditions to be true at the same time].
    OnBTN_4(Agent:agent):void =
        # Condition: Value_A must equal 2, AND Value_B must equal 10.0

        # Style 1: Separated by a comma `,` on the same line. More concise, and the style used most often in this course.
        if (Value_A = 2, Value_B = 10.0): 
            Print("if...then A:: Both conditions are met!")

        # Style 2: Block format. More readable and functionally identical. Recommended when you have many conditions.
        if:
            Value_A = 2
            Value_B = 10.0
        then:
            Print("if...then B:: Both conditions are also met!")

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# Try adjusting the execution order and the conditions to get a feel for the effect of execution order and logic.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 09 – Making More Precise Decisions: Comparison Operators
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Learn to use the 6 common "comparison operators".
#   `>`  : Greater than
#   `>=` : Greater than or equal to
#   `<`  : Less than
#   `<=` : Less than or equal to
#   `=`  : Equal to   (‼️Reminder: This is for comparison, not assignment with `set`!)
#   `<>` : Not equal to

# bites_comparison
bites_comparison := class(creative_device):

    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}
    @editable BTN_4 : button_device = button_device{}

    OnBegin<override>()<suspends>:void =
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
        BTN_4.InteractedWithEvent.Subscribe(OnBTN_4)

    Value_A : int = 5
    Value_B : int = 3

    # OnBTN_1: Greater than, Less than
    OnBTN_1(Agent:agent):void =
        if (Value_A < Value_B):
            Print("Value_A <  Value_B → true")
        else:
            Print("Value_A <  Value_B → false")   # ← This example will print

    # OnBTN_2: Greater than or equal to, Less than or equal to
    OnBTN_2(Agent:agent):void =
        if (Value_A <= Value_B):
            Print("Value_A <= Value_B → true")
        else:
            Print("Value_A <= Value_B → false")   # ← This example will print

    # OnBTN_3: Equal to
    OnBTN_3(Agent:agent):void =
        if (Value_A = Value_B):
            Print("Value_A  = Value_B → true")
        else:
            Print("Value_A  = Value_B → false")   # ← This example will print

    # OnBTN_4: Not equal to
    OnBTN_4(Agent:agent):void =
        if (Value_A <> Value_B):
            Print("Value_A <> Value_B → true")    # ← This example will print
        else:
            Print("Value_A <> Value_B → false")

    # Tip
    # Different operators support different data types:
    # `>` `>=` `<` `<=`  are mainly used for `int` and `float` numerical comparisons.
    # `=` `<>`           can be used for almost all types, like `int`, `float`, `logic`, and `string`.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 10 – Compound Conditions: or & and
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn how to combine multiple conditions to implement more complex decision logic.

# Sometimes, an `if` statement needs to consider more than one thing. This is where the logical operators `or` and `and` come in.
# → `or`: If [any one] of the multiple conditions is true, the result is true.
#   (e.g., To get into a movie theater, you need "a movie ticket" OR "a membership card". One is enough.)
# → `and`: [All] of the multiple conditions must be true for the result to be true.
#   (e.g., To drive a car, you need "a driver's license" AND "the car keys". You need both.)

# bites_decision
bites_decision := class(creative_device):

    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}

    @editable var MyMana : int = 5    # Player's current mana

    # Values
    MaxMana    : int = 20     # Max mana
    PotionGain : int = 10     # Mana restored by a potion
    FireCost   : int = 15     # Mana cost of a fireball

    OnBegin<override>()<suspends>:void =
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        Print("GAME START -- MyMana = {MyMana}")

    # OnBTN_1: `or` logic — "Do I have [at least one way] to cast a fireball?"
    # (This button only checks for possibilities; it doesn't actually consume mana)
    OnBTN_1(Agent:agent):void =
        # Condition A: I have enough mana right now (MyMana >= FireCost)
        # Condition B: I'll have enough mana after drinking a potion (MyMana + PotionGain >= FireCost)
        if ((MyMana >= FireCost) or (MyMana + PotionGain >= FireCost)):
            Print("Tip: You can cast a fireball! (Either directly, or after drinking a potion)")
        else:
            Print("Tip: Not enough mana. You can't cast a fireball either way.")
        Print("Check complete -- Current mana is still: {MyMana}")

    # OnBTN_2: `and` logic — "Do I meet [all conditions] to drink a potion and then cast a fireball?"
    # (This button checks the conditions, and if they pass, it will actually perform the actions)
    OnBTN_2(Agent:agent):void =
        # Condition 1: Current mana is not full, so drinking a potion isn't a waste (MyMana < MaxMana)
        # Condition 2: After drinking the potion and casting the fireball, remaining mana must not be negative
        if ((MyMana < MaxMana) and (MyMana + PotionGain - FireCost >= 0)):
            # Both conditions are met, perform the actions!
            Print("Conditions met, taking action...")
            set MyMana += PotionGain
            Print("Drank a potion, current mana: {MyMana}")
            set MyMana -= FireCost
            Print("Cast a fireball! Remaining mana: {MyMana}")
        else:
            Print("Action failed (mana is full or final mana would be < 0), no action taken.")
        Print("Action finished -- Current mana is: {MyMana}")

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# Want a challenge?
# 1. Add a `logic` variable for day/night, `IsDay`.
# 2. Add constants for two new spells: `LightCost` and `ShadowCost`.
# 3. Implement more complex logic:
#    The condition to cast [Light Magic] is: enough mana (`MyMana >= LightCost`) AND [it must be daytime] (`IsDay = true`).
#    The condition to cast [Shadow Magic] is: enough mana (`MyMana >= ShadowCost`) AND [it must be nighttime] (`IsDay = false`).
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 11 – Core Verse Concept: Failable Expressions
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Gain a preliminary understanding of one of Verse's most core and unique concepts: failable expressions.

#   Imagine you are casting a spell:
#   If the conditions are met (enough mana, correct incantation), the spell is [successful].
#   If the conditions are not met (e.g., not enough mana), the spell [fails]. But crucially, you don't explode or get hurt;
#   it's just that "nothing happens," and you can then do something else.
#   Verse's "failable expressions" are this [safe spellcasting] mechanism.

#   ‼️ Important: Failure ≠ Error
#   - Error: Like saying a spell wrong. This will cause a compile error (a red squiggly line), and the program cannot run at all.
#   - Failure: Like not having enough mana. This is an expected, normal outcome. The program will gracefully skip it and continue executing the subsequent code.
#   Summary: Your game won't crash the entire server because of a code failure; the failed code simply won't have an effect.

# bites_failable_expr
bites_failable_expr := class(creative_device):

    MaxMana : int = 20
    var MyMana : int = 5

    OnBegin<override>()<suspends>:void =
        Print("Game start, checking mana status...")

        # The conditional part of this `if` (MyMana = MaxMana) is a "failable expression."
        # Because 5 is not equal to 20, this expression will [fail].
        # After it fails, the `Print()` inside is simply skipped, and nothing happens.
        if (MyMana = MaxMana):
            Print("Mana is full! You can use your ultimate ability!")

        # The conditional part of this `if` (MyMana > 0) will also be attempted.
        # Because 5 is greater than 0, this expression will be [successful].
        # After it succeeds, the `Print()` inside will be executed.
        if (MyMana > 0):
            Print("You still have mana and can fight!")
        
        Print("Check complete.") # Even though the first if failed, the program still continues to execute this line.

    # Core Summary
    # 1. Everything is an Expression: In Verse, almost everything (including `if` statements) is an "expression" that produces a result after execution.
    # 2. Failing Safely: Some expressions can fail. On success, they produce a value; on failure, they produce no value, and the program acts as if it "never happened."
    # 3. `if` is the classic example: The condition after an `if` is a failable expression.
    #    - Condition is `true` -> Expression [succeeds] -> The code inside the `if` is executed.
    #    - Condition is `false`-> Expression [fails] -> The code inside the `if` is skipped.
    # 💡 You can think of it this way: **Failable Expression ≈ if**

# ── TRY IT YOURSELF (Thought Experiment) ──────────────────────────────────
# 1. Start the game and observe the output log. Did you only see "Game start...", "You still have mana...", and "Check complete."?
#    This proves that the first `if` was indeed skipped due to "failure."
# 2. Change the value of `MyMana` to 20 and test again.
#    Now predict, how many sentences will be printed? Did the messages from both `if` statements get printed out?
# 3. This is the practical application of failable expressions: allowing our code to safely handle all sorts of possible situations.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 12 – Data Type Conversion: int, float & string
# ────────────────────────────────────────────────────────────────────────────
#   Goal:
#   ▸ Convert int (integer) to float (floating-point)
#   ▸ Convert float to int (truncating/rounding)
#   ▸ Convert numbers to string for display

# bites_value_conversion
bites_value_conversion := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}
    @editable BTN_4 : button_device = button_device{}

    Value_A : int   = 18
    Value_B : float = 54.5

    OnBegin<override>()<suspends>:void =
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
        BTN_4.InteractedWithEvent.Subscribe(OnBTN_4)
        Print("--- Initial Values --- Value_A(int) = {Value_A}, Value_B(float) = {Value_B}")

    # OnBTN_1: int → float (integer → floating-point)
    OnBTN_1(Agent:agent):void =
        # The easiest way is to multiply by 1.0, which forces the result of the whole expression to become a float type.
        NewFloat_A : float = Value_A * 1.0
        Print("int to float: {Value_A} * 1.0  ➜  {NewFloat_A}")

    # OnBTN_2: float → int (direct truncation)
    OnBTN_2(Agent:agent):void =
        # ‼️ Connection to Lesson 11: `Int[]` is a [failable expression]!
        # `Int[]` will [truncate] all decimal parts, without rounding.
        if (NewInt_B := Int[Value_B]):
            Print("float to int (truncate): Int[{Value_B}]  ➜  {NewInt_B}")

    # OnBTN_3: float → int (professional rounding tools)
    OnBTN_3(Agent:agent):void =
        # `Floor[]` (Floor): Always rounds [down] to the nearest integer, no matter the decimal.
        if (Floor_B := Floor[Value_B]):
            Print("Floor (round down): Floor[{Value_B}]  ➜  {Floor_B}")  # 54

        # `Ceil[]` (Ceiling): Always rounds [up] to the nearest integer, no matter the decimal.
        if (Ceil_B := Ceil[Value_B]):
            Print("Ceil (round up): Ceil[{Value_B}]  ➜  {Ceil_B}")   # 55

        # `Round[]` (Round): Standard rounding.
        if (Round_B := Round[Value_B]):
            Print("Round (standard): Round[{Value_B}]  ➜  {Round_B}") # 55

    # OnBTN_4: Number → string (for display)
    OnBTN_4(Agent:agent):void =
        # Use `ToString()` to convert any number type to a string.
        # Method A: Create a [new constant] to store the converted string.
        String_A := ToString(Value_A)

        # Method B: Update an [existing variable].
        var TempString : string = ""
        set TempString = ToString(Value_B)

        Print("Conversion results: " + String_A + " and " + TempString)

        # Of course, the easier way is to embed directly in `Print` with {}, Verse will convert it for you automatically.
        Print("The easier way: {Value_A} and {Value_B}")


    # Important Notes
    # 1. Currently, Verse cannot convert a string back to an int or float.
    # 2. ⚠️⚠️⚠️ Type conversion converts the *result*, not the type of the field itself. So, Value_A and Value_B in the example do not change their types during execution.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 13 – Common Type: logic
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Learn about the `logic` type and how to use it to represent and toggle switch states.
#   You can simply think of `logic` as ON/OFF (true/false).
#   `true` : Represents "true," "yes," "on."
#   `false`: Represents "false," "no," "off."

# bites_logic_basic
bites_logic_basic := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}
    
    # Scenario: We have two states, one for "Is the door locked?" and another for "Is the security system active?"
    var IsDoorLocked : logic = true
    var IsSecurityActive : logic = true

    OnBegin<override>()<suspends>:void =
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
        
    # OnBTN_1: Check the current state
    OnBTN_1(Agent:agent):void =
        # Use `if` to check the current value of a logic variable.
        if (IsDoorLocked = true):
            Print("The current state of the door is: Locked")   # `IsDoorLocked` is initially true, so this line will print.
        else:
            Print("The current state of the door is: Unlocked")

    # OnBTN_2: Toggle a single state
    OnBTN_2(Agent:agent):void =
        # To reverse a state (on->off, off->on), we need to check the current state, then set it to the opposite.
        if (IsDoorLocked = true):
            set IsDoorLocked = false    # If it's true, make it false.
            Print("Action --- Unlocking")
        else:    
            set IsDoorLocked = true     # If it's false, make it true.
            Print("Action --- Locking")

        if (IsDoorLocked = true):
            Print("State after action: The door is locked.")
        else:
            Print("State after action: The door is unlocked.")

    # OnBTN_3: Compare two logic states
    OnBTN_3(Agent:agent):void =
        # 1. Use `=` to check if two logic values are [equal].
        #    Use case: Check if two systems have a consistent state.
        if (IsDoorLocked = IsSecurityActive):
            Print("Systems synced: Door lock and security states are consistent.")
        else:
            Print("Systems out of sync! Please check!")
        
        # 2. Use `<>` to check if two logic values are [not equal].
        if (IsDoorLocked <> IsSecurityActive):
            Print("Check result: States do not match.")
        else:
            Print("Check result: States match.")

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 14 – Query & not
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Learn to use `?` and `not` to write more concise and professional `if` conditional statements.

# bites_query
bites_query := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}

    # We define the variable's initial value directly in the code.
    var IsMorning : logic = false

    OnBegin<override>()<suspends>:void =
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)

    # OnBTN_1: Querying with `?`
    OnBTN_1(Agent:agent):void =
        # Adding `?` after a `logic` variable is like asking it a question: "Are you true?"
        # `if (IsMorning?)` is completely equivalent to `if (IsMorning = true)`, but this is the recommended style.
        if (IsMorning?):
            Print("Query `?`: It is morning.")
        else:
            Print("Query `?`: It is evening.")

    # OnBTN_2: Inverting a query with `not`
    OnBTN_2(Agent:agent):void =
        # The `not` keyword can [invert] the success/failure result of any failable expression.
        # It is completely equivalent to `if (IsMorning = false)`.
        if (not IsMorning?):
            Print("Query `not ?`: It is evening.")
        else:
            Print("Query `not ?`: It is morning.")

    # OnBTN_3: Combining `not` with other comparisons
    OnBTN_3(Agent:agent):void =
        # `not` can also be used to invert the result of other comparison operations.
        Value : int = 5
        # `not Value > 20` means: "If the check 'Value > 20' is not true..."
        if (not Value > 20):
            Print("`not >`: {Value} is indeed not greater than 20.") # ← This example will print
        else:
            Print("`not >`: {Value} is somehow greater than 20.")
        
        # Tip: `not Value > 20` is logically equivalent to `Value <= 20`.

    # Simple Summary
    #  - Use `if (LogicVariable?)` instead of `if (LogicVariable = true)`
    #  - Use `if (not LogicVariable?)` instead of `if (LogicVariable = false)`
    #  - `not` can invert the result of any conditional check.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Go back to your "Door Access System" code from Lesson 13.
# 2. Find all instances of `if (IsDoorLocked = true)` and change them to the more professional `if (IsDoorLocked?)`.
# 3. If you wrote a check like `if (HasKey = false)`, change it to `if (not HasKey?)`.
# 4. Challenge: Using the `if-then` syntax from Lesson 8 and the knowledge from this lesson, implement a compound check:
#    If the player [does not have the key] AND [the door is locked], print "You are locked out!"
#    (Hint: `if (not HasKey?, IsDoorLocked?):`)
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 15 – Scope
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Use the analogy of a company and its meetings to understand the logic of Scope.

# 0. You should go through this lesson once for a preliminary understanding, but you don't need to grasp everything completely.
#      Come back to review it after you finish Lesson 19. If it's still not perfectly clear, review it again after Lesson 35.

# 1. The 4 Common Scope Levels
#   → Global: Anything at the far left of the code is in the Global Scope.
#   → Class: Anything inside a Class is in the Class Scope.
#   → Function: Anything inside a Function is in the Function Scope.
#   → Block: The indented code block under statements like `if`, `loop`, etc.
#   → Scope across Verse files: Remember how we can't use the same Class name in the same project?
#     That's related to scope across files, but we'll cover that after Lesson 36.

# 2. Observing Global Scope
#   → Look at `CEO` and `Scope_Mobile_Office()`. They are a global Field and a global Function that can be used anywhere.
#   → You now know that Fields and Functions can be defined outside of a Class. More things can too, which we'll learn later.
#   → Resources at the same level in Global Scope can call each other, and there is `no sequential order` requirement.

# 3. Observing Class Scope
#   → Resources at the same level in Class Scope can also call each other, and there is also `no sequential order` requirement.
#     In this example, we intentionally placed the constants `Manager` and `MeetingRoom1` at the very end of the class to prove this.
#   → Observe Office A. We can have `Scope_Mobile_Office()` "enter" Office A, and we can have the `CEO` "participate" in the meeting.
#   → Observe Office A and Office B. They both have their own `Room_1()`, and they do not interfere with each other.

# 4. Observing Function Scope
#   → Look at `Room_1()`. It can access `Manager`, which was created in the Class Scope, but it cannot access `Customer_1`, which was created in `MeetingRoom()`.
#   → Inside a Function Scope, ⚠️ there is a `sequential order` requirement.
#   → Look at `MeetingRoom()`. The order of execution is `Customer_1` > `if (MeetingRoom1?)` > `Customer_2` > `if (MeetingRoom2?)`.
#   → Look at `MeetingRoom()`. `Customer_2` is created after the first `if`, so `if (MeetingRoom1?)` cannot access `Customer_2`.

# 5. Observing Block Scope
#   → Inside a Block Scope, ⚠️ there is a `sequential order` requirement.
#   → Look at `if (MeetingRoom2?)`. There's a `LateEmployee` who is created at the very end of the Block Scope, so he can't participate in the earlier part of the meeting!


# 〓 Global Scope
CEO : string = "(Unreal)"   

# 〓 Global Scope
Scope_Mobile_Office():void = 
    # 〓 Function Scope
    SpecialAssistant : string = "(Zoe)"
    Print("Mobile office meeting: Participants " + CEO + " and " + SpecialAssistant)
    # Room_1() # ❌ `Room_1()` is a function inside Office A and B; it cannot be called directly from the global scope.

# 〓 Global Scope
# bites_scope_office_a (Office A)
bites_scope_office_a := class(creative_device):
    # 〓 Class Scope
    OnBegin<override>()<suspends>:void =
        # 〓 Function Scope
        Print ("Who will lead the meeting?")
        Room_1()
        MeetingRoom()
        Scope_Mobile_Office()    

    Room_1():void =
        # 〓 Function Scope
        Employee_3 : string = "(Jack)"
        Print ( "Office A-Room1 Meeting:" + CEO + Manager + Employee_3)
        # Print ( "Office A-Room1 Meeting:" + CEO + Manager + Employee_1)   # ❌ Cannot see Eva / Lily / Ben

    MeetingRoom():void =
        # 〓 Function Scope
        Customer_1 : string = "(Lily)"

        if (MeetingRoom1?):
            # 〓 Block Scope
            Employee_1 : string = "(Eva)"
            Print ( "Meeting : " + Manager + Employee_1 + Customer_1)
            # Print ( "Meeting : " + Manager + Employee_2 + Customer_2)    # ❌ Cannot see Isaac / Ben (not yet declared)

        Customer_2 : string = "(Isaac)"

        if (MeetingRoom2?):
            # 〓 Block Scope
            Employee_2 : string = "(Ben)"
            Print ( "Meeting : " + CEO + Manager + Employee_2 + Customer_1 + Customer_2)

            # Print ( "Meeting : " + CEO + Manager + LateEmployee + Customer_1 + Customer_2)    # ❌ Cannot see Late (not yet declared)
            LateEmployee : string = "(Late)"

    Manager : string = "(Ann)"   
    MeetingRoom1 : logic = true
    MeetingRoom2 : logic = true

# 〓 Global Scope    
# bites_scope_office_b (Office B)
bites_scope_office_b := class(creative_device):
    # 〓 Class Scope
    Manager : string = "(Peter)"

    OnBegin<override>()<suspends>:void =
        # 〓 Function Scope
        Scope_Mobile_Office()
        Room_1()
        Room_2()

    # Room_1
    Room_1():void =
        # 〓 Function Scope
        Employee_1 : string = "(Sam)"
        Print ( "Office B-Room1 Meeting:" + CEO + Manager + Employee_1 )
        # Print ( "Office B-Room1 Meeting:" + CEO + Manager + Employee_2 )    # ❌ Cannot see Eva

    # Room_2    
    Room_2():void =
        # 〓 Function Scope
        Employee_2 : string = "(Eva)"
        Print ( "Office B-Room2 Meeting:" + CEO + Manager + Employee_2 )    # ❌ Cannot see Sam
        # Print ( "Office B-Room1 Meeting:" + CEO + Manager + Employee_1 )    # ❌ This Eva cannot see Sam

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# Come back to review this lesson after you finish Lesson 19. If it's still not perfectly clear, review it again after Lesson 35.
# How to handle Scope across Verse files will be explained in a future advanced lesson.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 16 – Function (1): The Building Blocks of Code
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Get a formal introduction to functions, and learn how to define and call a simple one.

# bites_function_1
bites_function_1 := class(creative_device):

    # `OnBegin` is a special function of `class(creative_device)` that we can just use directly.
    OnBegin<override>()<suspends>:void =
        DisplayWelcomeMessage()
        PlayStartSound()

    # --- Below are the functions we've defined ourselves ---
    # Define a function named DisplayWelcomeMessage
    DisplayWelcomeMessage():void =
        # The purpose of this function is to print a welcome message.
        Print("Welcome to my island!")

    # Define a function named PlayStartSound
    PlayStartSound():void =
        # Imagine there's code here to play a sound effect.
        Print("Played a 'beep' sound effect.")

    # Function Syntax Breakdown
    # Let's use `DisplayWelcomeMessage():void =` as an example:
    #   → `DisplayWelcomeMessage` : The name of the function, which you define. It's best if it describes what the function does.
    #   → `()`                    : The parameter list. It's empty for now, meaning no outside information is needed to run this function.
    #                             (We'll learn how to pass parameters in Lesson 18)
    #   → `:void`                 : The return type. `void` means this function does "not return" any result after it finishes.
    #                             (We'll be using `void` until Lesson 19)
    #   → `=`                     : The assignment operator, indicating that the body of the function is the indented code block that follows.

    # Naming Style Suggestions
    #   → Function Name (e.g., `DisplayWelcomeMessage`): Recommended to use PascalCase (first letter of each word capitalized).
    #   → Class Name (e.g., `bites_function_1`): Recommended to use all lowercase with words separated by underscores.
    #     After Lesson 36, you will learn usage patterns like `BitesFunction_1 : bites_function_1 = bites_function_1{}`.
    
# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# At this point, you can go back and review the Functions from the previous lessons.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 17 – Functions (2): Modifying Variables
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Create a Function that can change existing variables.

# bites_function_2
bites_function_2 := class(creative_device):
    # When naming referenced devices, it's recommended to use a naming convention like `ALL_CAPS_` format.
    # This makes it easier for game designers to identify them in UEFN and improves readability in the Verse code.
    @editable BTN_AddMana : button_device = button_device{}
    @editable BTN_SubMana : button_device = button_device{}

    # Value
    var MyMana : int = 10      # Current mana
    AddAmount : int = 5      # Amount to add
    SubAmount : int = -5     # Amount to subtract (achieved with a negative number)

    OnBegin<override>()<suspends>:void =
        Print("Game start, initial mana is: {MyMana}")
        BTN_AddMana.InteractedWithEvent.Subscribe(OnAddMana)
        BTN_SubMana.InteractedWithEvent.Subscribe(OnSubMana)

    # OnAddMana
    OnAddMana(Agent:agent):void =
        set MyMana += AddAmount
        Print("Mana increased! Current mana = {MyMana}")

    # OnSubMana
    OnSubMana(Agent:agent):void =
        # Use the `set` command on MyMana to add SubAmount
        #   Since SubAmount is negative, the final result will be a subtraction.
        set MyMana += SubAmount 
        Print("Mana decreased! Current mana = {MyMana}")

    # ▼▼▼ Execution Flow Breakdown (when BTN_AddMana is pressed)
    # 1. The `Subscribe` in `OnBegin` starts a new thread to listen for the Button Device's `InteractedWithEvent`.
    # 2. The player presses the button, triggering the `InteractedWithEvent`, which then executes `OnAddMana(Agent:agent):void=`.
    # 3. The code inside the `OnAddMana` function executes in order:
    #    `set MyMana += AddAmount`, increasing MyMana by 5.
    #    Then, `Print` outputs the result after the increase.

    # ▼▼▼ Food for Thought...
    # Have you noticed that the `OnAddMana` and `OnSubMana` functions are almost identical in structure, apart from the value being changed?
    # They both modify `MyMana` and then `Print` the result.
    # In the next lesson, we will learn how to use "function parameters" to create a more concise and manageable solution.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson 18 – Functions (3): Parameters
# ────────────────────────────────────────────────────────────────────────────
#   Goal: Learn to create parameters for functions to eliminate code duplication and create truly flexible "functional modules".

# ─── Creating a Method with Parameters
# First, let's look at the function `HandleManaEvent(Delta:int):void =`
#   Inside the `()`, we define the parameters this function needs to receive.
#   The format is `Name:Type`, for example: (ID:int), (Health:float), (Name:string).
#   This new field will only be effective within the scope of this function and cannot have the same name as a field in an outer scope.
#   Observe where `HandleManaEvent` is called in the code, and what parameters they input and what the results are.

# ─── Using a Method with Parameters
# To use a method with parameters, you must satisfy the input parameters it requires.
#   Look at the `OnAddMana` method. It calls `HandleManaEvent` and provides the necessary parameter inside the `()`.
#   Two common errors when calling methods:
#      1. Not providing the corresponding parameters, or the parameter type is wrong, or the number of parameters is incorrect.
#      2. A common beginner mistake: when you create a method that doesn't need parameters, don't forget the `()`!

# ─── Multiple Parameters
# Next, let's look at the function `PrintInitValues(Message:string, Value:int):void =`
#   This is a function with two parameters.
#   Observe where `PrintInitValues` is called in the code, and what parameters they input and what the results are.

# bites_function_3
bites_function_3 := class(creative_device):
    @editable BTN_AddMana : button_device = button_device{}
    @editable BTN_SubMana : button_device = button_device{}

    var MyMana      : int = 10
    AddAmount     : int = 5
    SubAmount     : int = -5

    OnBegin<override>()<suspends>:void =
        PrintInitValues("Initial amount to add", AddAmount)   # When calling, "Initial amount to add" and AddAmount are the parameters we input.
        PrintInitValues("Initial amount to subtract", SubAmount)
        # PrintInitValues("Missing one parameter")   # ❌ Missing a parameter, this will cause an error.

        BTN_AddMana.InteractedWithEvent.Subscribe(OnAddMana)
        BTN_SubMana.InteractedWithEvent.Subscribe(OnSubMana)

    # HandleManaEvent
    HandleManaEvent(Delta:int):void =   # Delta is an integer type "parameter".
        set MyMana += Delta             # When the method executes, MyMana will be increased by the int parameter assigned to Delta.
        PrintInitValues("Mana change complete! Current mana", MyMana)

    # PrintInitValues
    PrintInitValues(Message:string, Value:int):void =   # When defining, Message and Value are "parameters".
        Print("{Message} = {Value}")

    # OnAddMana and OnSubMana now act as "task dispatchers".
    OnAddMana(Agent:agent):void =
        PrintInitValues("Used potion, mana restored", AddAmount)
        HandleManaEvent(AddAmount)      # We input AddAmount (value 5) as the parameter.
        # HandleManaEvent()             # ❌ No parameter provided, will cause an error.
        # HandleManaEvent               # ❌❌❌ Be careful, omitting `()` won't cause an error here, but it might lead to issues after building.

    OnSubMana(IamAgent:agent):void =
        PrintInitValues("Used spell, mana consumed", SubAmount)
        HandleManaEvent(SubAmount)      # We input SubAmount (value -5) as the parameter.

    # ─── About (Agent:agent)
    #   When we use `Subscribe` for events like button interactions, the Verse API requires that our handler function
    #   [must] have a parameter of type `(Agent:agent)` to receive information about "who triggered this event."
    #   Even if we don't use this information for now, we must include it as required, or it will cause an error.
    #   As explained earlier in the course, `agent` is the type, and `Agent` is the name we give the parameter.
    #   How do we know what parameters each function needs? We'll learn that in Lesson 21.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#  Lesson 19 – Functions (4): Return Values
# ────────────────────────────────────────────────────────────────────────────
# Goal: Create a function that can return a result. It's time to do something about `void`!

# ─── Creating a Function That Can Return a Result
# First, let's look at the function `HandleManaEvent(Delta:int):int =`
#   1. Modify the return type: Change the `:void` at the end of the function to the data type you want to return,
#      for example, `:int` or `:logic`.
#   2. Use `return`: In the function body, use the `return` keyword, followed by the specific value you want to return.
#      The type of this value must exactly match the return type you declared in step 1!

# ─── Getting the Value from a Function with a Return Result
# We've created a function that can return a result, so now we need to get that result.
#   Look at how the `OnAddMana` method calls `HandleManaEvent`.
#   First, we create a new constant `NewManaValue`.
#   Here, using `:=` is equivalent to `: int =`. When capturing a return value, `:=` automatically infers the type of the returned value.
#   Then, its value becomes the result returned by `HandleManaEvent`.

# ─── Using if Statements in a Function with a Return Result
#   Functions often need `if` statements to process results, but be aware that `if` must be paired with `else` in this context.
#   Look at the `CheckMana` function. Did you notice? This function can have multiple `return` results.
#   You can see more applications of multiple `return`s in the Verse-Bites project.

# bites_function_return
bites_function_return := class(creative_device):

    @editable BTN_AddMana : button_device = button_device{}
    @editable BTN_SubMana : button_device = button_device{}

    var MyMana      : int = 10
    AddAmount     : int = 5
    SubAmount     : int = -5

    OnBegin<override>()<suspends>:void =
        BTN_AddMana.InteractedWithEvent.Subscribe(OnAddMana)
        BTN_SubMana.InteractedWithEvent.Subscribe(OnSubMana)

    # OnAddMana
    OnAddMana(Agent:agent):void =
        # First, create a new constant `NewManaValue`, whose value is the result of `HandleManaEvent`.
        NewManaValue := HandleManaEvent(AddAmount)
        # Then, we input the result of this value into the PrintManaState method to print the result.
        PrintManaState(NewManaValue)

    # OnSubMana 
    OnSubMana(Agent:agent):void =
        PrintManaState(HandleManaEvent(SubAmount))    # A more concise usage.

    # PrintManaState
    PrintManaState(ManaValue:int):void =
        # Here, we use the CheckMana method to check and get the state's logic value.
        IsManaNegative := CheckMana(ManaValue)
        if (IsManaNegative?):
            Print("Warning: Mana value {ManaValue} is now negative!")
        else:
            Print("Mana value {ManaValue} is still sufficient!")

    # --- Function Definitions with Return Values ---
    # 1. This function returns a result of type `int`.
    HandleManaEvent(Delta:int):int =
        set MyMana += Delta
        return MyMana       # `return` followed by MyMana means the function will return MyMana as the result.

    # 2. This function returns a result of type `logic`.
    CheckMana(Value:int):logic =
        if (Value < 0):
            return true     # If mana is less than 0, return true.
        else:
            return false    # Otherwise, return false.

    # ─── Common Questions
    #   1. Can `HandleManaEvent` work even if I delete `return`? Yes, when a function has a return type, as long as the very last line
    #      evaluates to the correct type, it will work. But! Please maintain good habits and add `return` where it belongs.
    #   2. When a function has an `if` statement, does it need an `else`? Yes, if the `if` could be the last expression in the function,
    #      it must have an `else` to guarantee the function always produces a value of the declared return type.


# ── TRY IT YOURSELF (The Ultimate Refactoring Challenge!) ──────────────────────
# This is a milestone in your learning. Take a break and review the previous lessons. The upcoming lessons
# will require you to have a solid understanding of lessons 1-19.
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson - 20 : Option
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn to use the `option` type to safely handle values that "might not exist."
# You can think of it as a [box]: it either [contains an integer] or it's [empty].
# For example: a player might have a weapon equipped, or they might not; a treasure chest might contain an item, or it might be empty.
# To handle these situations safely, Verse provides the [option type].

# bites_option
bites_option := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}

    # Creating variables of an option type
    # Add `?` before any type to make it an option type.
    # An option type can hold two kinds of values: one is `false`, and the other is a value of the original type.
    var oOption_A : ?int = false         # Initialize with `false`
    var oOption_B : ?int = option{72}  # Initialize with a value of 72, using the `option{}` syntax, then fill in `72`
    var oOption_C : ?float = false       
    var oOption_D : ?string = false   

    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)

    # Print_oOption_A  
    Print_oOption_A():void=  
        # ‼️ To get the value of an Option, you must use the Query method from Lesson 14. Remember? Go back and review!
        # Add `?` after `oOption_A` to query it.
        # `Option_A` uses `:=` to get the same type and value as `oOption_A`.

        if (Option_A := oOption_A?):    
            Print ("If oOption_A has a value, display oOption_A = {Option_A}")
        else:
            Print ("If oOption_A has no value, display oOption_A = false")

        # Naming Suggestion
        #   Have you noticed the naming convention I use for option types?
        #   I add a lowercase `o` at the beginning of the name, which makes it easy to identify this field as an Option type.
        #   When querying for the value, I remove the `o` to represent the actual result.

    # OnBTN_1
    OnBTN_1(Agent:agent):void =
        Print_oOption_A()

    # OnBTN_2
    OnBTN_2(Agent:agent):void =
        # How to set the value of an option type
        # It's also done with `set`, but you must add the `option{}` syntax, then fill in the value you want to input.
        set oOption_A = option{55}
        Print_oOption_A()

    # OnBTN_3
    OnBTN_3(Agent:agent):void =
        # To set an option to a state with no value, just `set` it directly to `false`.
        set oOption_A = false
        Print_oOption_A()

    # `option` is used for handling special types, like `player` and `agent`.
    #   This is because when creating fields of these types, you can't directly assign a specific value; the value needs to be passed in during runtime.
    #   For example, `var FirstPlayer : player = `, you can't provide a specific value after `=`.
    #   The correct way is `var FirstPlayer : ?player = false`. We'll learn the detailed usage in later lessons.

    # Extended Topic
    # (1). When to use `A := 6`? (2). When to use `A : int = 6`? (3). When to use `A : int`?
    # You can understand it more simply like this:
    #   - When you want to create a new field, use `: int =`.
    #   - When your field is equal to another field, use `:=`, for example when querying or getting a return value from a Function.
    #   - In fixed-functionality syntax where you only need the field and type, such as when creating a Function with input Parameters.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson - 21 : Array (1)
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn to use arrays to store and manage a sequential series of data.
# In programming, we often need to store an ordered "series" of data, like a team's scores, a list of items in an inventory, etc.
#
# Arrays have two core rules:
# 1. All lockers must contain items of the [same type]. (For example, in an `[]int` array, each locker can only hold an integer).
# 2. Each locker has a unique number, which is its [Index].
# ‼️ Important Rule: Index numbers always start from [0]! The first locker is number 0, the second is 1, and so on.

# bites_array_1
bites_array_1 := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}

    # Create an Array
    #   Add `[]` before any type to create an array of that type.
    #   Array values need to use the `array{}` syntax, and each "value" is placed inside, separated by commas.
    # Below, `Array_1`'s `array{}` has no values (an empty row of lockers).
    var Array_1 : []int = array{}
    # Below, `Array_2`'s `array{}` has 5 values. No comma is needed after the last value.
    var Array_2 : []int = array{10, 20, 30, 40, 50}
    var Array_3 : []float = array{25.56, 10.7, 15.5, 3.5}       # `Array_3` has 4 values in its `array{}`.
    var Array_4 : []logic = array{false, false, true}          # `Array_4` has 3 values in its `array{}`.

    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)

    IndexToGet : int = 3    # Prepare an int field to represent which locker number we want to open.

    # OnBTN_1: Accessing values in an array
    OnBTN_1(Agent:agent):void =
        # To access a value in an array, you must use `if`, because the value you're trying to get might not exist (e.g., you look for locker #10 when there are only 5).
        #   Use the syntax `Array_2[]`, and inside `[]`, enter the index ID you want, which must be an int.
        #   Remember: in code, numbers start from 0.
        if (Value := Array_2[1]):       # Input the index ID you want in `[]`, then test the result.
            Print("Successfully opened locker #1, the value inside is: {Value}")
        else:
            Print("Failed to open locker #1, perhaps this number doesn't exist.")   # If the input index ID has no value, it will fail, and you'll see this message.
 
    # OnBTN_2
    OnBTN_2(Agent:agent):void =
        # You can use a field for the integer index. This can be more intuitive in some development processes and allows you to modify the value to retrieve.
        if (Value := Array_2[IndexToGet]):
            Print("Successfully opened locker #{IndexToGet}, the value inside is: {Value}")
        else:
            Print("Failed to open locker #{IndexToGet}!")

    # OnBTN_3: Getting the length of an array
    OnBTN_3(Agent:agent):void =
        # Add `.Length` after the Array field, and it will directly return the total number of values in that Array field (as an int).
        ArrayLength := Array_2.Length        
        Print("Array_X Length = {ArrayLength}")
        # Or use a more direct method
        Print("Array_X Length = {Array_2.Length}")

    # Remember in `Lesson 12 – Data Type Conversion`, the method to convert a float to an int?
    #   `if (NewInt_B := Int[Value_B]):`
    #   Did you notice? When getting or indexing inside an `if`, `[]` is used instead of `()`. Why?
    #   This is related to failable expressions, but for now, you just need to remember that most of the time when you get or index inside an `if`, you use `[]`.

    # Note: This course tries to reduce the number of new terms during the learning process.
    #   For example, in the official documentation, the items inside an Array are called Elements.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson - 22 : For and Range 
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn to use the `for` loop to automate repetitive tasks, especially for iterating over all elements in an array.

# When we need to perform the [same operation] on a series of data (like all elements in an array),
# writing the code one by one is very tedious. This is when we need a [loop] to help us automate the repetitive work.
#
# You can think of a `for` loop as a [hardworking robot]. You give it a list (like a row of lockers)
# and a set of instructions. It will start from the first one and faithfully execute your instructions on [every single] locker
# until it's all done.

# bites_for
bites_for := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}
    @editable BTN_4 : button_device = button_device{}

    var Array_1 : []int = array{10, 20, 30}

    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)
        BTN_4.InteractedWithEvent.Subscribe(OnBTN_4)

    # OnBTN_1
    OnBTN_1(Agent:agent):void =
        # `range` uses the syntax `start_integer..end_integer` to create a sequence of numbers.
        #   Method to create a range: `starting int value` + `..` + `ending int value`
        # `for` is a loop syntax. `for` will complete its internal loop before executing the next piece of code.
        # The code below commands the robot to count from 0 to 2.
        Print ("Robot starts counting...")   # This code executes before the for loop.

        for (Count := 0..2):
            # The code inside the loop body will be executed 3 times (for 0, 1, 2).
            Print("Current count: {Count}")

        Print ("...counting finished.")    # This code executes after the for loop.

    # OnBTN_2
    OnBTN_2(Agent:agent):void =
        # Using `for` to process an array.
        # You can use a range to create the scope for indexing an array.
        for (Index := 0..2):
            if (Value := Array_1[Index]):       # Remember this from the last lesson?
                Print("Step1 : Array_1 ID_{Index} = {Value}")

        # You can also use an integer-type field instead of literal numbers in the range.
        #   This way, you can dynamically modify the range's scope.
        #   Did you notice? In Verse code, parameters of the same type can all be handled using fields.
        var RangeMini : int = 0
        var RangeMax : int = 1
        for (Index := RangeMini..RangeMax):
            if (Value := Array_1[Index]):
                Print("Step2 : Array_1 ID_{Index} = {Value}")

        # In many cases, you'll need to iterate through all items in an array, making a fixed range inconvenient.
        #   We can directly get the total count of the array, then `-1` to automatically adjust the range.
        #   We use `-1` because code starts counting from `0`, so the total count must be reduced by 1 to get the max index.
        for (Index := 0..Array_1.Length - 1):
            if (Value := Array_1[Index]):
                Print("Step3 : Array_1 ID_{Index} = {Value}")

    # OnBTN_3
    OnBTN_3(Agent:agent):void =
        # Next, we'll introduce a method that doesn't use `range`. This is the more common method.
        #   In a `for` loop, use the `Key -> Element : Array_1` syntax. Here, `Key` and `Element` are custom-named fields.
        #   When indexing an `Array` in a `for` loop, `Key` will equal `0..Array_1.Length - 1`.
        #   `Element` is the value obtained after indexing.
        for (Key -> Element : Array_1):
            Print("Step1 : {Element} in Array_1 at index {Key}")

        # When iterating through an Array, I usually name the `Key` as `Index` directly, for better readability.
        #   And `Element` is the actual result of your Array's value, which you can name according to your project's needs.
        for (Index -> Value : Array_1):
            Print("Step2 : {Value} in Array_1 at index {Index}")

    # OnBTN_4
    OnBTN_4(Agent:agent):void =
        # This is a more concise method for iterating through all items in an array.
        #   It directly omits the `Key`, using `Element : Array_1`.
        #   Does this notation look familiar? Go review the extended topic in `Lesson 20`!
        for (Value : Array_1):
            Print("Array_1 = {Value}")

    # ─── Summary 
    #   - `for (i := 0..N)`: Executes a block of code N+1 times.
    #   - `for (Index -> Value : MyArray)`: Iterates through an array, getting both the index and the value. (Most common)
    #   - `for (Value : MyArray)`: Iterates through an array, getting only the value.

    # `for` has other advanced uses that will be covered in advanced lessons.

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson - 23 : Array (2) - Adding and Modifying Arrays
# ────────────────────────────────────────────────────────────────────────────
# Goal: Learn how to add elements to, modify, and dynamically build an array.

# bites_array_2
bites_array_2 := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}

    var IntBOX : []int = array{}
    var FloatBOX : []float = array{}
    var LogicBOX : []logic = array{}

    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)

    # A helper function to print the current state of IntBox, making it easy to observe changes.
    PrintArray(StepID:int):void=
        Print("Step_{StepID} IntBOX Length = {IntBOX.Length}")
        for (Index -> Value : IntBOX):
            Print("IntBOX Index_{Index} = {Value}")

    # OnBTN_1: Adding elements to an array
    OnBTN_1(Agent:agent):void =
        # Step 1: Initial state. The array is empty, so nothing will be printed.
        PrintArray(1)

        # Step 2: Adding elements to the array.
        #   Use `+=` to [append] new elements to the end of the array. It's like adding a new locker to the end of the row.
        #   The elements to be added must be placed in `array{}`.
        set IntBOX += array{10}          # IntBox is now array{10}
        PrintArray(2)

        # Step 3: You can append multiple elements at once.
        set IntBOX += array{20, 15}      # IntBox is now array{10, 20, 15}
        PrintArray(3)

        # Step 4: Use `=` to directly [overwrite] the entire array. This example shows clearing it, so it resets every time the button is pressed.
        set IntBOX = array{}             # IntBOX is now an empty array{}
        PrintArray(4)
        
    # OnBTN_2: Combining and modifying array elements
    OnBTN_2(Agent:agent):void =
        # Step 1: Arrays can be combined using `+`.
        IntBOX_2 : []int = array{3, 1}
        IntBOX_3 : []int = array{0}
        set IntBOX = IntBOX_2 + array{5, 4} + IntBOX_3   # The result for IntBOX is array{3, 1, 5, 4, 0}
        PrintArray(1)

        # Step 2: Modifying an element at a specific index.
        #   When we add elements, we use `set` directly, but that action adds elements to the array, it doesn't modify them.
        #   Since the index might not exist, this operation is a [failable expression] and requires `if`. For example, if you input an index greater than the array size.
        #   Use `[]` to input which element you want to modify. Remember! The first number in code starts from `0`!
        if (set IntBOX[2] = 77) {}      # Modify the element at index 2 (the third one) to 77. Try changing the parameters and observe the result.
        PrintArray(2)
        # Reset the array for the next test.
        set IntBOX = array{}    

    # OnBTN_3: Using a for loop to build an array
    OnBTN_3(Agent:agent):void =
        # In games, we often need to create temporary data or lists. Using a for loop is the most common way.
        # Case 1: For the empty array FloatBOX, add {5.0, 4.0, 3.0, 2.0, 1.0}.
        for (RangeValue := 1..5):
            # Remember! The value from `range` is an `int`. We need to multiply by 1.0 here to convert it to a float.
            set FloatBOX += array{ 6.0 - (RangeValue * 1.0) }
        # Print the result directly with a for loop.
        for (Value : FloatBOX):
            Print("FloatBOX = {Value}")
        set FloatBOX = array{}      # Reset Array

        # Case 2: Creating and processing a logic array.
        #   You might suddenly not know how to use it when the type isn't a number. Here's an example.
        set LogicBOX += array{true, false, false, true} 
        Print("Logic Length = {LogicBOX.Length}")
        for (Index -> Logic : LogicBOX):
            if (Logic?):
                Print("Index_{Index} = true")
            else:
                Print("Index_{Index} = false")    
        set LogicBOX = array{}      # Reset Array

        <# Tips
        # Did you notice something different about `if (set IntBOX[2] = 77) {}`?
        # In this case, the `if` statement ends with `{}` instead of `:`. Here are the two styles:
        # Style 1 is the one you're familiar with, using `:`.
        ```
        if (set IntBOX[2] = 77):
            Print ("Style A")
        ```  
        # Style 2 uses `{}` at the end, which can save some vertical space.
        ```
        if (set IntBOX[2] = 77) { Print ("Style B") }
        ```
        # Good habit to build: For some failable expressions that must use an `if` but have no further code to execute upon success, use `{}` at the end.
        #>

# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Create a string array `var PlayerInventory : []string = array{"Sword"}`.
# 2. In OnBTN_1, use `+=` to add "Shield" and "Potion" to your inventory.
# 3. In OnBTN_2, the player's "Sword" has been upgraded. Please use `set PlayerInventory[0] = "Magic Sword"` to update it.
# 4. After each operation, use a `for` loop to print out all items in the current inventory to check if the operation was successful!
# ═════════════════════════════════════════════════════════════════════════════



# ═════════════════════════════════════════════════════════════════════════════
#   Lesson - 24 : Array (3) - Finding, Removing, and More Tools
# ────────────────────────────────────────────────────────────────────────────
# Goal: Understand the underlying logic of removing array elements and master the powerful built-in tools Verse provides to simplify these operations.

# bites_array_3
bites_array_3 := class(creative_device):
    @editable BTN_1 : button_device = button_device{}
    @editable BTN_2 : button_device = button_device{}
    @editable BTN_3 : button_device = button_device{}

    var IntBOX : []int = array{5, 6, 7, 8, 9}    
    IntBOX_Default : []int = array{5, 6, 7, 8, 9} 

    OnBegin<override>()<suspends>:void=
        BTN_1.InteractedWithEvent.Subscribe(OnBTN_1)
        BTN_2.InteractedWithEvent.Subscribe(OnBTN_2)
        BTN_3.InteractedWithEvent.Subscribe(OnBTN_3)

    # Helper function to print and reset IntBox.
    PrintAndResetIntBOX(StepID:int):void=  
        Print("Step_{StepID} IntBOX Length = {IntBOX.Length}")
        for (Value : IntBOX):
            Print("IntBOX = {Value}")
        set IntBOX = IntBOX_Default     # Reset the array

    # OnBTN_1: Removing elements manually (to understand the underlying logic)
    OnBTN_1(Agent:agent):void =
        # Step 1: Find and remove. Remove 7 from {5, 6, 7, 8, 9}.
        # (1) Create a new empty int array variable to act as a container for the "filtered" results.
        var NewArray : []int = array{} 
        # (2) Iterate through the entire original Array.
        for (IntValue : IntBOX):
            # (3) In each loop, compare the element with the target value 7.
            if (IntValue <> 7):
                # (4) If the element is not 7, then add it to the new NewArray.
                set NewArray += array{IntValue}
        # After the for loop finishes, we have a NewArray that does not contain 7.
        # (5) Assign the result to IntBOX. Done.
        set IntBOX = NewArray       
        PrintAndResetIntBOX(1)

        # Cool. Now you might be exclaiming, "Wow, what did I just go through!?"
        # If you can, try to understand this logic. It's helpful for developing your logical thinking for future designs.
        # The way to learn more logic is to see more logic. You don't need to understand it completely, but the more you know, the better it helps your thinking.

    # OnBTN_2: Tools for Finding and Removing
    OnBTN_2(Agent:agent):void =
        # Fortunately, Verse now provides many built-in tools that can simplify a lot of work.

        # Step 1: Find the element 8.
        # .Find not only finds the target element but also returns its position (index) in the Array.
        # .Find will only return the position of the first occurrence.
        if (Index := IntBOX.Find[8]):   
            Print ("Find at index: {Index}")
        else:    
            Print ("Not Found")

        # Step 2: Remove the 3rd element (at index 2).
        # An array cannot be changed directly. Similar to the complex logic above, you need a "filtered" container, then set the result back to IntBOX.
        if (NewBox := IntBOX.RemoveElement[2]):   
            set IntBOX = NewBox
            PrintAndResetIntBOX(2)

        # Step 3: Insert the element 4 at the 2nd position (index 1).
        if (NewBox := IntBOX.Insert[1, array{4}]):    
            set IntBOX = NewBox
            PrintAndResetIntBOX(3)

        # ------ You can be aware of the following functions, but you don't need to memorize them --------    

        # Step 4: Remove elements from StartIndex(2) up to, but not including, StopIndex(4).
        if (NewBox := IntBOX.Remove[2, 4]): 
            set IntBOX = NewBox
            PrintAndResetIntBOX(4)

        # Step 5: Remove the first element that is equal to 6.
        if (NewBox := IntBOX.RemoveFirstElement[6]):   
            set IntBOX = NewBox
            PrintAndResetIntBOX(5)
        
        # Step 6: Replace the 2nd element (at index 1) with 5.
        if (NewBox := IntBOX.ReplaceElement[1, 5]): 
            set IntBOX = NewBox
            PrintAndResetIntBOX(6)

    # OnBTN_3
    OnBTN_3(Agent:agent):void =
        # Step 1: Replace the first element equal to Value(9) with NewValue(20).
        if (NewBox := IntBOX.ReplaceFirstElement[9, 20]): 
            set IntBOX = NewBox
            PrintAndResetIntBOX(1)

        # Step 2: Remove all elements equal to Value.
        NewBox2 := IntBOX.RemoveAllElements(8)
        set IntBOX = NewBox2
        PrintAndResetIntBOX(2)

        # Step 3: Replace all 7s with 35s.
        NewBox3 := IntBOX.ReplaceAllElements(7, 35) 
        set IntBOX = NewBox3
        PrintAndResetIntBOX(3)
        
# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
# 1. Create a quest log: `var Quests : []string = array{"Defeat Goblins", "Find the Gem", "Speak to the King", "Find the Gem"}`.
# 2. [Find]: Use `.Find[]` to find and print the index of the "Speak to the King" quest.
# 3. [Complete Quest]: The player has completed the first "Find the Gem" quest. Use `.RemoveFirstElement[]` to remove it.
# 4. [Update Quest]: Use `.ReplaceElement[,]` to update the quest at index 0 ("Defeat Goblins") to "Report to the Guard".
# 5. After each operation, use a `for` loop to print out the latest quest list!
# ═════════════════════════════════════════════════════════════════════════════
