-- include 'push' library; used to manipulate the resolution
push = require 'push'
-- a library used to create classes
Class = require 'class'
-- invoking our own code
require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    love.window.setTitle("Pong")
    -- apply the nearest-neighbor (aka Point) filter
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    -- creating 2 font objects; used to display welcome message and score
    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 32)

    -- setup the window (aka the field of our game)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }

    -- create paddle objects for the players
    player1 = Paddle(10, 30)
    player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 50)
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2)

    gameState = 'start'
    winner = ''
end

function love.resize(w, h)
    push:resize(w, h)
end

-- A LÖVE2D callback function that executes whenever we press a key
function love.keypressed(key) 
    -- state machine
    if key == 'enter' or key == 'return' then 
        if gameState == 'start' then
            gameState = 'play'
        elseif gameState == 'done' then
            gameState = 'start'
            player1.score = 0
            player2.score = 0
            ball:reset()
        else 
            gameState = 'start'
            ball:reset()
        end
    end
    -- terminate the game when 'escape' key is pressed
    if key == 'escape' then
        love.event.quit()
    end
end

-- Runs every frame, with "dt" passed in, our delta in seconds since the last frame, which LÖVE2D supplies us.
function love.update(dt) 
    if gameState == 'play' then

        if ball.dx < 0 then
            bx, by = ball.x, ball.y
            while bx > 15 do
                bx = bx + ball.dx * dt
                by = by + ball.dy * dt
            end
            if player1.y < by and player1.y + player1:getWH('h') > by then
                player1:move(0)
            elseif player1.y < by then
                player1:move(dt)
            elseif player1.y > by then
                player1:move(-dt)
            end
        end

        -- deflect the ball if collided with paddles
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
            sounds['paddle_hit']:play()
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 5
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
            sounds['paddle_hit']:play()
        end
        -- detect upper and lower boundaries collision, if collided deflect the ball
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
            sounds['wall_hit']:play()
        end
        if ball.y > VIRTUAL_HEIGHT - ball:getWH('h') then
            ball.y = VIRTUAL_HEIGHT - ball:getWH('h')
            ball.dy = -ball.dy
            sounds['wall_hit']:play()
        end
        -- if ball is past the left or right edge, score a point 
        if ball.x + ball:getWH('w') < 0 then
            player2.score = player2.score + 1
            ball:reset()
            if player2.score == 10 then
                winner = 'player2'
                gameState = 'done'
            else
                gameState = 'start'
            end
            sounds['score']:play()
        elseif ball.x > VIRTUAL_WIDTH then
            player1.score = player1.score + 1
            ball:reset()
            if player1.score == 10 then
                winner = 'AI'
                gameState = 'done'
            else
                gameState = 'start'
            end
            sounds['score']:play()
        end

        ball:move(dt)
    end
    -- player1 movement
    -- if love.keyboard.isDown('w') then
    --     player1:move(-dt)
    -- elseif love.keyboard.isDown('s') then
    --     player1:move(dt)
    -- end

    -- player2 movement
    if love.keyboard.isDown('up') then
        player2:move(-dt)
    elseif love.keyboard.isDown('down') then
        player2:move(dt)
    end
end

-- display frame per seconds
function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0)
    love.graphics.print('FPS: ' .. love.timer.getFPS(), 10, 10)
end

-- called each frame by love2D; used to render the game
function love.draw()
    push:start()
    -- change the background color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    -- render the paddles and the ball
    player1:render()
    player2:render()
    ball:render()

    if not (gameState == 'play') then
        -- render text using smallFont 
        love.graphics.setFont(smallFont)
        love.graphics.printf("Ping Pong!", 0, 10, VIRTUAL_WIDTH, "center")
        if gameState == 'done' then
            love.graphics.printf(winner .. " wins", 0, 20, VIRTUAL_WIDTH, 'center')
        else
            love.graphics.printf("press enter to play", 0, 20, VIRTUAL_WIDTH, 'center')
        end

        -- render score using largeFont
        love.graphics.setFont(largeFont)
        love.graphics.print(tostring(player1.score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
        love.graphics.print(tostring(player2.score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

        displayFPS()
    end

    push:finish()
end