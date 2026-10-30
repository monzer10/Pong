Paddle = Class{}

-- constants, accessable only within this file
local PADDLE_SPEED = 200
local WIDTH = 5
local HEIGHT = 20

-- initializer; used to construct objects
function Paddle:init(x, y)
    self.x = x
    self.y = y
    self.score = 0
end

function Paddle:getWH(x)
    if x == 'w' then
        return WIDTH
    elseif x == 'h' then
        return HEIGHT
    end
end

-- moves the paddle along the vertical axis
function Paddle:move(dy)
    if dy < 0 then
        self.y = math.max(0, self.y + PADDLE_SPEED * dy)
    else
        self.y = math.min(VIRTUAL_HEIGHT - HEIGHT, self.y + PADDLE_SPEED * dy)
    end
end

-- draw the paddle to the screen
function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, WIDTH, HEIGHT)
end