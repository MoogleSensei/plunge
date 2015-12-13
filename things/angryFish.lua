local AngryFish         = Class{
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    depth = 0,
    dir = 0,
    speed = 0,
}

function AngryFish:init()
    self.x,self.y = 0, 0
    self.width = 16
    self.height = 16
    self.depth = 600
    self.dir = -1
    self.speed = 5
end

function AngryFish:update(dt)
    self:move(self.dir, self.speed)
    if self.x < playFieldXMin then
        self.x = playFieldXMin
        self.dir = -self.dir
    end
    if self.x > playFieldXMax then
        self.x = playFieldXMax
        self.dir = -self.dir
    end
end

function AngryFish:draw(currDepth)
    love.graphics.setColor(255,0,0)
    -- print(self.x.." : "..self.depth - (currDepth - 3*screenHeight/4))
    love.graphics.rectangle("fill",self.x,self.depth - (currDepth - 3*screenHeight/4),self.width,self.height)
end

function AngryFish:move(dir, amount)
    self.x = self.x + dir*amount
end

function AngryFish:getX()
    return self.x
end

return AngryFish
