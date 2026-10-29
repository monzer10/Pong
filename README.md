# Pong

A Pong project written in Lua with the [LÖVE](https://love2d.org/) game framework.

## Project status

This project is an early prototype. It displays a Pong scene but does not yet support playable matches.

### Implemented

- Two stationary paddles and a stationary ball.
- A “Hello Pong!” message.
- A retro-style font.
- A virtual resolution of 432 × 243 pixels, displayed in a fixed 1280 × 720 window.
- An Escape key shortcut to close the application.

### Not yet implemented

- Paddle movement.
- Ball movement and collision detection.
- Scoring.
- Match start, restart, and win conditions.

## Requirements

- LÖVE installed on your computer.
- Git, if you want to clone the repository from the command line.

LÖVE includes the Lua runtime. You do not need a separate Lua installation.

## Download and run

1. Install LÖVE from https://love2d.org/.
2. Clone this repository:

   ```sh
   git clone https://github.com/monzer10/Pong.git
   cd Pong
   ```

   Alternatively, download the repository as a ZIP file and extract it.

3. From the directory that contains `main.lua`, start the application:

   ```sh
   love .
   ```

   This command requires the LÖVE executable to be available on your `PATH`.

On Windows, you can also drag the project folder onto `love.exe`.

Do not start the project with `lua main.lua`. The application requires the LÖVE runtime.

## Controls

| Key | Action |
| --- | --- |
| Escape | Close the application |

Paddle controls are not implemented yet.

## Project files

| File | Purpose |
| --- | --- |
| `main.lua` | Initializes the window, handles the Escape key, and draws the scene. |
| `push.lua` | Provides virtual-resolution rendering and display scaling. |
| `font.ttf` | Provides the font used for the on-screen text. |
| `README.md` | Describes the project and explains how to run it. |

## Troubleshooting

### The `love` command is not found

Install LÖVE and add its executable directory to your `PATH`. Alternatively, launch the project folder with the LÖVE application.

### The application cannot find a file

Keep `main.lua`, `push.lua`, and `font.ttf` in the same directory. Run `love .` from that directory.

### The paddles and ball do not move

This is expected in the current prototype. Movement and gameplay logic are not implemented yet.

## Credits

- Project author: [monzer10](https://github.com/monzer10).
- `push.lua`: Copyright © 2020 Ulysse Ramage. Its license notice is included in the file.
