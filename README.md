# Pong

A Lua-based Pong game built with the [LÖVE](https://love2d.org/) framework. This project is a playable arcade-style clone featuring a single-player setup against an AI opponent, score tracking, sound effects, and responsive 2D gameplay.

## Overview

Pong is one of the classic arcade games, and this project recreates the experience in a lightweight and beginner-friendly format. The game uses a virtual resolution to keep the gameplay proportional while scaling to a larger window, making it easy to run on different screen sizes.

The project is organized into a few small Lua files:

- `main.lua` handles the game loop, rendering, input, scoring, and state transitions
- `Paddle.lua` defines the paddle behavior and rendering
- `Ball.lua` defines movement, collision detection, reset logic, and rendering
- `class.lua` provides a minimal class system used by the game objects
- `push.lua` provides virtual-resolution scaling for the LÖVE window

## Features

- Player-vs-AI Pong gameplay
- Keyboard controls for the player paddle
- Ball movement and wall collisions
- Paddle collision detection and bounce logic
- Score tracking and match-over state
- Start and restart flow with the Enter key
- Sound effects for paddle hits, wall bounces, and scoring
- Virtual 432 × 243 game resolution scaled to a 1280 × 720 window
- Nearest-neighbor rendering for retro-style visuals

## Gameplay

The game starts in a menu state and waits for the player to press Enter to begin. Once the match begins, the ball moves automatically and the player's paddle is controlled with the up and down arrow keys. The AI controls the left paddle and attempts to return the ball.

A point is scored when the ball crosses the left or right edge. The first player to reach 10 points wins the round. After a completed match, pressing Enter starts a new game.

## Controls

| Key | Action |
| --- | --- |
| Up Arrow | Move player paddle up |
| Down Arrow | Move player paddle down |
| Enter | Start a match / restart after a round |
| Escape | Quit the game |

## Requirements

Before running the project, make sure you have:

- [LÖVE 2D](https://love2d.org/) installed on your computer
- A standard Lua environment is not required separately because LÖVE includes Lua
- Git if you want to clone the repository from the command line

## Installation and Run

1. Clone the repository:

   ```bash
   git clone https://github.com/monzer10/Pong.git
   cd Pong
   ```

2. Start the game:

   ```bash
   love .
   ```

3. If LÖVE is installed correctly, the game window will launch.

Alternative option on Windows:

- Drag the project folder onto `love.exe`.

Important: do not run the game with `lua main.lua`. This project is designed to run through the LÖVE runtime.

## Project Structure

```text
Pong/
├── Ball.lua
├── Paddle.lua
├── README.md
├── class.lua
├── font.ttf
├── main.lua
├── push.lua
├── sounds/
│   ├── paddle_hit.wav
│   ├── score.wav
│   └── wall_hit.wav
└── updates/
```

## File Descriptions

### `main.lua`
The main game script. It initializes the window, loads the sound effects, creates the paddle and ball objects, handles input, manages the game states, and renders the frame each update.

### `Paddle.lua`
Defines the paddle object, including its position, speed, movement logic, and drawing function.

### `Ball.lua`
Defines the ball object, speed, movement, collision logic, reset behavior, and rendering.

### `class.lua`
Tiny class utility used to structure game objects in an object-oriented way without heavy dependencies.

### `push.lua`
Library for virtual resolution scaling. It allows the game to be rendered in a fixed internal resolution while fitting naturally into a larger window.

### `sounds/`
Contains the sound effects used for collisions and scoring.

## Technical Notes

This game uses a virtual game space instead of relying directly on the window dimensions. The main logic runs in a 432 × 243 coordinate system, and `push.lua` scales it to fit the browser or desktop window size cleanly.

The project uses a minimal custom class system rather than a large engine, making it a great example of a lightweight game built with Lua and LÖVE.

## Troubleshooting

### The `love` command is not found
Install LÖVE and make sure the executable is available in your `PATH`. If needed, start the project folder directly via the LÖVE application.

### The project does not start
Ensure that you are running the game from the project directory and that the `main.lua` file is present.

### Files are missing or textures look wrong
Keep `main.lua`, `Paddle.lua`, `Ball.lua`, `push.lua`, `class.lua`, and `font.ttf` in the same folder, and run the game from that directory.

## Credits

- Project author: [monzer10](https://github.com/monzer10)
- `push.lua`: Copyright © 2020 Ulysse Ramage. License text is included in the file.
- This project uses the LÖVE game framework and standard Lua-based game development patterns.

## License

This repository does not currently include a license file. If you plan to publish or distribute the project publicly, consider adding an open-source license such as MIT.

## Future Improvements

Potential upgrades for the project include:

- Player 1 keyboard controls as an option
- Improved AI difficulty
- Pause menu and settings screen
- Better match transitions and scoreboard UI
- Additional visual polish and animations
- Mobile or more advanced input support

