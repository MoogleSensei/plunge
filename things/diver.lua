local Diver         = Class{
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    depth = 0,
    diveAmount = 0,
    riseRate = 0,
    riseRateMax = 0,
    riseAccel = 0,
    riseAccelMax = 0,
    isAlive = false
}

function Diver:init()
    self.x,self.y = 0, 0
    self.width = 32
    self.height = 32
    self.depth = 0
    self.diveAmount = 80
    self.riseRate = 0
    self.riseRateMax = 1000
    self.riseAccel = 0
    self.riseAccelMax = 250
    self.isAlive = true
end

function Diver:update(dt)
    Diver.riseAccel = Diver.riseAccel + 50*dt
    if Diver.riseAccel >= Diver.riseAccelMax then Diver.riseAccel = Diver.riseAccelMax end
    Diver.riseRate = Diver.riseRate + Diver.riseAccel*dt
    if Diver.riseRate >= Diver.riseRateMax then Diver.riseRate = Diver.riseRateMax end
    Diver.y = Diver.y - Diver.riseRate*dt
    Diver.depth = Diver.depth - Diver.riseRate*dt
    if Diver.depth <= 3*screenHeight/4 then
        if Diver.y <= 10 then Diver.y = 10 end
        if Diver.depth <= 0 then Diver.depth = 0 end
    else
        if Diver.y <= screenHeight/4 then Diver.y = screenHeight/4 end
        if Diver.y >= 3*screenHeight/4 then Diver.y = 3*screenHeight/4 end
    end
    if Diver.y + Diver.height >= screenHeight then Diver.y = screenHeight - Diver.height end
    if Diver.x <= 0 then Diver.x = 0 end
    if Diver.x + Diver.width >= screenWidth then Diver.x = screenWidth - Diver.width end
end

function Diver:draw()
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
end

function Diver:movePlayer(dir)
    Diver.x = Diver.x + 24*dir
    Diver.y = Diver.y + Diver.diveAmount
    Diver.depth = Diver.depth + Diver.diveAmount
    Diver.riseAccel = Diver.riseAccel - 5
    if Diver.riseAccel <= 0 then Diver.riseAccel = 0 end
    Diver.riseRate = Diver.riseRate/2
    if Diver.riseRate <= 0 then Diver.riseRate = 0 end
end

return Diver
