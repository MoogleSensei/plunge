local Diver          = Class{
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    depth = 0,
    diveAmount = 0,
    diveDir = 0,
    diveAmountDecel = 0,
    riseRate = 0,
    riseRateMax = 0,
    riseAccel = 0,
    riseAccelMax = 0,
    isAlive = false
}

function Diver:init()
    self.width = 32
    self.height = 32
    self.x,self.y = screenWidth/2-self.width/2, 0
    self.depth = 0
    self.diveAmount = 16
    self.diveAmountMax = 16
    self.diveDir = -1
    self.diveAmountDecel = 16
    self.riseRate = 0
    self.riseRateMax = 1000
    self.riseAccel = 0
    self.riseAccelMax = 250
    self.isAlive = true
end

function Diver:update(dt)
    if not(self.diveAmountDecel >= self.diveAmountMax) then
        self.diveAmountDecel = self.diveAmountDecel + 1
        Diver:movePlayer(self.diveDir,self.diveAmount-self.diveAmountDecel)
    end

    Diver.riseAccel = Diver.riseAccel + 50*dt
    if Diver.riseAccel >= Diver.riseAccelMax then Diver.riseAccel = Diver.riseAccelMax end
    Diver.riseRate = Diver.riseRate + Diver.riseAccel*dt
    if Diver.riseRate >= Diver.riseRateMax then Diver.riseRate = Diver.riseRateMax end

    Diver.y = Diver.y - Diver.riseRate*dt
    Diver.depth = Diver.depth - Diver.riseRate*dt
    if Diver.depth <= 0 then
        Diver.depth = 0
        Diver.riseRate = 0
        Diver.riseAccel = 0
    end
    if Diver.y <= screenHeight/4 then Diver.y = screenHeight/4 end
    if Diver.y >= 3*screenHeight/4 then Diver.y = 3*screenHeight/4 end

    if Diver.x <= 0 then Diver.x = 0 end
    if Diver.x + Diver.width >= screenWidth then Diver.x = screenWidth - Diver.width end
end

function Diver:draw()
    love.graphics.setColor(255-darkness/2,255-darkness/2,255-darkness/2)
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
end

function Diver:movePlayer(dir, diveAmount)
    -- if dir == 'l' then Diver.x = Diver.x - Diver.diveAmount end
    -- if dir == 'r' then Diver.x = Diver.x + Diver.diveAmount end
    -- if dir == 'u' then
    --     Diver.y = Diver.y - Diver.diveAmount
    --     Diver.depth = Diver.depth - Diver.diveAmount
    -- end
    -- if dir == 'd' then
    --     Diver.y = Diver.y + Diver.diveAmount
    --     Diver.depth = Diver.depth + Diver.diveAmount
    -- end
    -- print("Diver: "..Diver.x.." : "..Diver.depth)
    Diver.x = Diver.x + 3*diveAmount*dir/4
    if Diver.riseRate <= diveAmount then
        Diver.y = Diver.y + diveAmount - Diver.riseRate
        Diver.depth = Diver.depth + diveAmount - Diver.riseRate
    end
    Diver.riseAccel = Diver.riseAccel - 2
    if Diver.riseAccel <= 0 then Diver.riseAccel = 0 end
    Diver.riseRate = Diver.riseRate/2
    if Diver.riseRate <= 0 then Diver.riseRate = 0 end
end

function Diver:startDive(dir)
    self.diveDir = dir
    self.diveAmount = self.diveAmountMax
    self.diveAmountDecel = 0
end

function Diver:endDive()
    -- self.diveDir = dir
    self.diveAmount = self.diveAmountMax
    self.diveAmountDecel = self.diveAmountMax
end

return Diver
