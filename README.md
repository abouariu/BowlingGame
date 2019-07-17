# BowlingGame

The is an implementation of the [Bowling Kata](https://github.com/stephane-genicot/katas/blob/master/Bowling.md) using Swift.

#### 1. Prerequisites

Xcode 10.2.

The code uses no other dependencies.

#### 2. Getting started

##### Clone the project

    git clone https://github.com/csfnaicsf/2019_DEV_183

##### Run the project

Open `BowlingGame.xcodeproj`.

Run tests (`cmd + U`).

Run project (`cmd + R`). The project does not have any team set, so it can be launched in the simulator. To run on a device, a team must be selected in the project general settings.

##### Use the application

After running the application, tap the "Roll" button to input the number of hit pins.
The application will group the rolls into frames. After completing the 10th frame, the "Roll" button will become "Get Score" and will display the final score.

To restart the game, tap "Start Over".

In order to keep this kata light, the data validation is basic. Even if invalid input is allowed (such as a frame with two rolls that sum up to more than 10 hit pins), the purpose of this challenge is to determine the final score for valid input.
