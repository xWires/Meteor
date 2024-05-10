# Meteor

Meteor is a game based on the 1979 arcade game by Atari, "Asteroids". Meteor is developed solely by me in the Godot game engine.

Controls (Keyboard and Mouse)

- W or Right Click is thrust
- A is turn left
- S for reversing
- D for turning right
- Left Click to fire
- ESC to pause

Controls (Controller)

- Left Stick / D-Pad for turning
- A/B for thrust
- Right Trigger for fire
- X for reversing
- Options to pause

To change the way the game works, you can use environment variables. Here is a list of environment variables you can set:

- METEOR_P_ACCELERATION: Used to set how fast the player accelerates, the default is 5
- METEOR_P_DECELERATION: Used to set how fast the player decelerates, the default is 0.5
- METEOR_P_MAXSPEED: Used to set the maximum speed of the player, the default is 200
- METEOR_P_ROTSPEED: Used to set how fast the player rotates, the default is 3
- METEOR_P_FIRECOOLDOWN: Used to set the cooldown for firing, default is 0.5
- METEOR_G_FLAGS: A comma seperated list of flags to set that change things about the game, the current list of game flags is: nodamage, nometeors, and noscoresave. "nodamage" disables collision between the player and meteors, "nometeors" stops meteors from spawning, and "noscoresave" prevents the game from saving your high score. Make sure you surround the list in quotes.

To use these on Windows, right click in the folder Meteor is in, and click "Open in Terminal". The following example shows what to type to change the firing cooldown, but you can change it to something else if you would like:
```powershell
$env:METEOR_P_FIRECOOLDOWN = 0.1
```
You can do this multiple times to change multiple different variables.
Then run Meteor like this:
```powershell
.\Meteor-Windows-v1.2.exe # Or if your version of Meteor is named something else, change it to that, make sure to include the '.\' though
```
On Linux you can set variables like this:
```bash
export METEOR_P_FIRECOOLDOWN=0.1
```
Again, you can do this multiple times.
Then run Meteor like this:
```bash
./Meteor-Linux-v1.2.x86_64
```
These changes are (intentionally) not permanent so if you close the terminal then you will have to do it again next time.

Your settings and high score are stored in "C:/Users/[name]/AppData/Roaming/Godot/app_userdata/Meteor/options.cfg" on Windows, and on Linux it is stored at "/home/[name]/.local/share/godot/app_userdata/Meteor/options.cfg".


The latest version of Meteor is available [here](https://github.com/xWires/Meteor/releases/latest), scroll down to the bottom of that page and choose the version you need, Windows or Linux.

Meteor is licensed under the GPLv3 license, and the "Vector Battle" font is licensed under a seperate license which can be found in the "vector_battle" folder.

