local Diver          = Class{
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    depth = 0,
    depthMin = 0,
    diveAmount = 0,
    diveDir = 0,
    riseRate = 0,
    riseRateMax = 0,
    riseAccel = 0,
    riseAccelMax = 0,
    health = 0,
    upgradeTank = 0,
    upgradeTankMax = 0,
    upgradeTankCost = 0,
    upgradeFlippers = 0,
    upgradeFlippersMax = 0,
    upgradeFlippersCost = 0,
    upgradeSubmarine = 0,
    upgradeSubmarineMax = 0,
    upgradeSubmarineCost = 0,
    upgradeArmor = 0,
    upgradeArmorMax = 0,
    upgradeArmorCost = 0,
    isAlive = false,
    deathTimer = 0
}

function Diver:init()
    self.width = 32
    self.height = 32
    self.x,self.y = screenWidth/2-self.width/2, 0
    self.depth = 0
    self.depthMin = 0
    self.diveAmountMax = 16
    self.diveAmount = self.diveAmountMax
    self.diveDir = -1
    self.riseRate = 0
    self.riseRateMax = 500
    self.riseAccel = 0
    self.riseAccelMax = 100
    self.healthMax = 5
    self.health = self.healthMax
    self.upgradeTank = 1
    self.upgradeTankMax = 10
    self.upgradeTankCost = 100
    self.upgradeFlippers = 1
    self.upgradeFlippersMax = 10
    self.upgradeFlippersCost = 100
    self.upgradeSubmarine = 1
    self.upgradeSubmarineMax = 6
    self.upgradeSubmarineCost = 500
    self.upgradeArmor = 5
    self.upgradeArmorMax = 30
    self.upgradeArmorCost = 50
    self.isAlive = true
    self.deathTimer = 0
end

function Diver:update(dt)
    if self.health <= 0 then
        self.isAlive = false
        self.deathTimer = self.deathTimer + dt
    else
        if not(self.diveAmount >= self.diveAmountMax) then
            self.diveAmount = self.diveAmount + 1
            self:movePlayer(self.diveDir,self.diveAmount)
        end
        self.riseAccel = self.riseAccel + 50*dt*(self.upgradeTank+1)
        if self.riseAccel >= self.riseAccelMax then self.riseAccel = self.riseAccelMax end
        self.riseRate = self.riseRate + self.riseAccel*dt
        if self.riseRate >= self.riseRateMax then self.riseRate = self.riseRateMax end

        self.y = self.y - self.riseRate*dt
        self.depth = self.depth - self.riseRate*dt
        if self.depth <= self.depthMin then
            self.depth = self.depthMin
            self.riseRate = 0
            self.riseAccel = 0
        end
        if self.y <= screenHeight/4 then self.y = screenHeight/4 end
        if self.y >= 3*screenHeight/4 then self.y = 3*screenHeight/4 end

        if self.x <= playFieldXMin then self.x = playFieldXMin end
        if self.x + self.width >= screenWidth - 50 then self.x = screenWidth - self.width - 50 end
    end
end

function Diver:draw()
    love.graphics.setColor(255-darkness/2,255-darkness/2,255-darkness/2)
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    love.graphics.setColor(32,32,32)
    for i=0,self.healthMax-1 do
        love.graphics.rectangle("fill",screenWidth/5 + (3*screenWidth/5/10)*(i%10) + 24,math.floor(i/10)*20+4,16,16)
    end
    love.graphics.setColor(255-darkness/2,0,0)
    for i=0,self.health-1 do
        love.graphics.rectangle("fill",screenWidth/5 + (3*screenWidth/5/10)*(i%10) + 2 + 24,math.floor(i/10)*20+4 + 2,12,12)
    end
    if not(self.isAlive) then
        local deathAlpha = 128*self.deathTimer
        if deathAlpha >= 255 then
            deathAlpha = 255
        end
        love.graphics.setColor(128,0,0,deathAlpha)
        love.graphics.rectangle('fill',0,3*screenHeight/4,screenWidth/2,screenHeight/4)
        love.graphics.setColor(0,128,0,deathAlpha)
        love.graphics.rectangle('fill',screenWidth/2,3*screenHeight/4,screenWidth/2,screenHeight/4)
        love.graphics.setColor(255,255,255,deathAlpha)
        love.graphics.push()
            love.graphics.setFont(font72)
            love.graphics.printf("You have died.\nPlay again?",0,screenHeight/4,screenWidth,'center')
            love.graphics.setFont(font48)
            love.graphics.printf("NO!",0,7*screenHeight/8,screenWidth/2,'center')
            love.graphics.printf("Yes...",screenWidth/2,7*screenHeight/8,screenWidth/2,'center')
        love.graphics.pop()
    end
end

function Diver:upgrade(upgradeName)
    if upgradeName == "Upgrade Tank" then
        if self.upgradeTank < self.upgradeTankMax and coinsInBank >= self.upgradeTankCost then
            coinsInBank = coinsInBank - self.upgradeTankCost
            self.upgradeTank = self.upgradeTank + 1
            self.riseRateMax = self.riseRateMax + 200*self.upgradeTank
            self.riseRate = self.riseRateMax
            self.riseAccelMax = self.riseAccelMax + 25*(self.upgradeTank-1)
            self.riseAccel = self.riseAccelMax
            if self.upgradeTank == self.upgradeTankMax then
                self.upgradeTankCost = "N/A"
            else
                self.upgradeTankCost = self.upgradeTankCost + 10*self.upgradeTank
            end
        end
    elseif upgradeName == "Upgrade Flippers" then
        if self.upgradeFlippers < self.upgradeFlippersMax and coinsInBank >= self.upgradeFlippersCost then
            coinsInBank = coinsInBank - self.upgradeFlippersCost
            self.upgradeFlippers = self.upgradeFlippers + 1
            self.diveAmountMax = self.diveAmountMax + 8--4*self.upgradeFlippers
            self.diveAmount = self.diveAmountMax
            if self.upgradeFlippers == self.upgradeFlippersMax then
                self.upgradeFlippersCost = "N/A"
            else
                self.upgradeFlippersCost = self.upgradeFlippersCost + 15*self.upgradeFlippers
            end
        end
    elseif upgradeName == "Upgrade Submarine" then
        if self.upgradeSubmarine < self.upgradeSubmarineMax and coinsInBank >= self.upgradeSubmarineCost then
            coinsInBank = coinsInBank - self.upgradeSubmarineCost
            self.upgradeSubmarine = self.upgradeSubmarine + 1
            if self.upgradeSubmarine == 2 then
                self.depthMin = 10000
                self.upgradeSubmarineCost = 1000
            elseif self.upgradeSubmarine == 3 then
                self.depthMin = 20000
                self.upgradeSubmarineCost = 2000
            elseif self.upgradeSubmarine == 4 then
                self.depthMin = 50000
                self.upgradeSubmarineCost = 5000
            elseif self.upgradeSubmarine == 5 then
                self.depthMin = 100000
                self.upgradeSubmarineCost = 10000
            elseif self.upgradeSubmarine == 6 then
                self.depthMin = 200000
                self.upgradeSubmarineCost = "N/A"
            end
            self.depth = self.depthMin
        end
    elseif upgradeName == "Upgrade Armor" then
        if self.upgradeArmor < self.upgradeArmorMax and coinsInBank >= self.upgradeArmorCost then
            coinsInBank = coinsInBank - self.upgradeArmorCost
            self.upgradeArmor = self.upgradeArmor + 1
            self.healthMax = self.healthMax + 1
            self.health = self.healthMax
            if self.upgradeArmor == self.upgradeArmorMax then
                self.upgradeArmorCost = "N/A"
            else
                self.upgradeArmorCost = self.upgradeArmorCost + 5*self.upgradeArmor
            end
        end
    end
end

function Diver:movePlayer(dir, amount)
    self.x = self.x + 8*dir
    if self.riseRate <= amount then
        if amount >= 32 then amount = 32 end
        self.y = self.y + amount - self.riseRate
        self.depth = self.depth + amount - self.riseRate
    end
    self.riseAccel = self.riseAccel/2
    self.riseRate = self.riseRate/2
end

function Diver:startDive(dir)
    self.diveDir = dir
    self.diveAmount = 0
end

function Diver:endDive()
    self.diveAmount = self.diveAmountMax
end

return Diver
