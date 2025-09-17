# Welcome to the Verse-Bites Learning Journey\!

Ready to dive into the world of Verse programming? This guide will walk you through all the necessary preparations to get you started smoothly with your first lesson.

[⚡️Jump to .Lesson-Bites Roadmap](https://github.com/UnrealRider/Verse-Bites/blob/main/Lesson-Bites/Lesson-Bites%20Roadmap.md)

## A Friendly Tip Before You Begin

Before diving deep into Verse, we **strongly recommend** you have a basic operational knowledge of UEFN. If you're new to UEFN, no worries\! You can get up to speed by learning the fundamentals from these excellent YouTube channels first:

  * **Recommended for Beginners:** **[@GraemeBull](https://www.youtube.com/@GraemeBull)**
  * **Recommended for Advanced Skills:** **[@howtwoboss](https://www.youtube.com/@howtwoboss)**

-----

## Environment Setup: Get Ready in 6 Steps

Please follow the steps below to set up your learning environment.

> 🎥 **Video Tutorial (Coming Soon):**

### Step 1: Install Visual Studio Code

Visual Studio Code (VS Code) is the official tool for writing Verse code. Before launching UEFN, please make sure you have it installed.

  * ➡️ **[Download from the official Visual Studio Code website](https://code.visualstudio.com/)**

### Step 2: Prepare Your UEFN Project

  * Launch or create a new UEFN project for your studies.

  * **💡 Template Suggestion:** We recommend using the **Blank** template. Its clean and minimalist environment is perfect for both learning and testing, helping you stay focused while improving load times.

    <img width="1469" height="879" alt="5a98389c-12d6-4e05-9e31-31c55356e098" src="https://github.com/user-attachments/assets/517c3530-8e93-42c6-8eb2-548a6f7a73b5" />

### Step 3: Create the Verse File Structure

A good directory structure is key to effective project management.

1.  In the UEFN top menu bar, click `Verse` \> `Open Project in VS Code`. This will automatically open VS Code and navigate to your current project folder.

    <img width="976" height="294" alt="image" src="https://github.com/user-attachments/assets/0939d3dd-6f33-4d93-a4e2-66e4480ac6b4" />

2.  **💡 Directory Sync Tip:** The project folder in VS Code is perfectly synchronized with the UEFN Content Browser. Any file or folder you create, modify, or delete in one application will be instantly updated in the other.

    <img width="1065" height="440" alt="0b0bbedd-0b9e-4e09-b2ef-4ec68480482f" src="https://github.com/user-attachments/assets/315a4b9d-0774-414d-9c8d-8288a0bb4f18" />

3.  Now, let's create the required folder structure for the course in VS Code. Please create the following structure in your project's root directory:

    ```
    📂 YourProjectName (Your Project Root)
    └─ 📂 Verse
       └─ 📂 VerseBites
          └─ 📂 LessonBites
    ```

      * **Folder Purpose:**
          * `Verse`: The main folder to store all your Verse code.
          * `VerseBites`: The folder for all resources related to this project (`Verse-Bites`).
          * `LessonBites`: The folder for all learning resources related to this course (`LessonBites`).

    The image below shows the corresponding structure in VS Code and the UEFN Content Browser:
    <img width="885" height="375" alt="0123c254-0ac0-4f11-bdcb-6c125b72d816" src="https://github.com/user-attachments/assets/97435a06-f3f9-46fb-a658-2accba765df1" />

4.  **❗ Important Note:** Creative Devices generated from `.verse` files will appear in the same folder as their source file. The hierarchical relationship between folders affects how code can be accessed and called. Therefore, planning your directory structure from the start is crucial.

### Step 4: Import and Build the Course Code

1.  In VS Code, create a new file named `Lesson-Bites_L1.verse` inside the `LessonBites` folder.

2.  Go to GitHub, copy the entire content of **[Lesson-Bites\_L1.verse](https://github.com/UnrealRider/Verse-Bites/blob/main/Lesson-Bites/Lesson-Bites_L1.verse)**, paste it into your local file of the same name, and save it.

    <img width="1890" height="743" alt="7b50bf8c-455d-4adc-a7e5-0f136c43cc6b" src="https://github.com/user-attachments/assets/a371a7da-b0ef-414f-97e1-46fc8000f9a6" />

3.  **Build the Code**: You can either click the `Build Verse Code` button in the top-right corner of VS Code or go back to UEFN and click `Verse` \> `Build Verse Code`.

    <img width="1273" height="409" alt="014d7298-52da-4418-bf69-5611bd8dd644" src="https://github.com/user-attachments/assets/8b6d9a4b-69bc-4ead-b147-a11193b349de" />

4.  **Check the Build Result**: Upon successful compilation, the `OUTPUT` window in VS Code will display a success message. Simultaneously, several Verse-generated Devices will appear in the `LessonBites` folder in UEFN.

    <img width="1273" height="946" alt="50ac188f-d48a-4f17-957a-958150a54328" src="https://github.com/user-attachments/assets/3226b258-50aa-4536-a9c3-99127f222b64" />

    > If the build fails, please take a screenshot of the complete error message and ask for help in our Discord community.

### Step 5: Create `MyBites.verse`

1.  In VS Code, create a new file named `MyBites.verse` inside the `Verse` folder. `MyBites.verse` will be your personal workspace for practicing Verse code.

2.  **Important!** You should not modify the content of `Lesson-Bites_L1.verse` directly. Instead, copy the snippets you are studying from the lesson file into `MyBites.verse` to work with them.

3.  After you build the code in `MyBites.verse`, any Verse Devices generated from it will be located inside the `Verse` folder.


### Step 6: Start Learning\!

You're all set\! Now you can officially begin your learning journey.

1.  Head over to the **[Lesson-Bites Roadmap.md](https://github.com/UnrealRider/Verse-Bites/blob/main/Lesson-Bites/Lesson-Bites%20Roadmap.md)**, choose the lesson you want to study, and watch the corresponding video tutorial.
2.  The first lesson will explain in detail how to use the `Lesson-Bites_L1.verse` file. Once you're familiar with the basic workflow, you can learn independently by following the subsequent videos and the comments within the code.

-----

## Join Our Community

The best way to learn programming is by interacting with others. We welcome you to join our Discord community\!

<a href="http://discord.gg/AhU7WkUdUD"><img src="https://img.shields.io/discord/YOUR_SERVER_ID?logo=discord&label=Discord" alt="Discord"></a>

  * **`#course-discussions`**: Every lesson has a dedicated discussion thread. If you encounter issues with a specific lesson, please ask questions and provide suggestions in the corresponding thread.
  * **`#my-adventure-log`**: Create your personal learning log here\! Share your progress, challenges, and thoughts. Your feedback is a valuable reference for improving the course.
  * **`#suggestions-and-feedback`**: Have any ideas or suggestions for the course content? Feel free to share them here\!

-----

## Tips for Effective Learning

  * **Focus on Understanding, Not Memorizing**: Try to understand the concepts first and build a mental model. It's more effective to revisit lessons after completing a few than to memorize them on the first pass.
  * **The "Copy-Paste-Modify" Method**: In the beginning, this is the most efficient way to learn. Once you feel confident with a feature, try writing the code from scratch.
  * **Learning Path**: We highly recommend completing the foundational lessons (1-35) in order before moving on to the advanced courses.
  * **Engage Actively**: Don't be afraid to ask questions. Every interaction in our Discord community makes the learning journey easier for you and everyone else.

-----

## Verse FAQ

> To be updated later...
