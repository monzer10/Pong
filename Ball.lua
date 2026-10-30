Ball = Class{}

local WIDTH = 4
local HEIGHT = 4

function Ball:init(x, y) 
    self.x = x
    self.y = y
    self.dx = math.random(2) == 1 and 150 or -150
    self.dy = math.random(-50, 50) 
end

function Ball:getWH(x)
    if x == 'w' then
        return WIDTH
    elseif x == 'h' then
        return HEIGHT
    end
end

function Ball:collides(paddle) 
    if self.x > paddle.x + paddle:getWH('w') or paddle.x > self.x + WIDTH then
        return false
    end
    if self.y > paddle.y + paddle:getWH('h') or paddle.y > self.y + HEIGHT then
        return false
    end
    
    return true
end

function Ball:move(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = math.random(2) == 1 and 150 or -150
    self.dy = math.random(-50, 50)
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, WIDTH, HEIGHT)
end