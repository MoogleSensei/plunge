local Enemies      = Class{
    list = {},
    width = 0,
    height = 0,
    minDepth = 0,
    maxDepth = 0,
    angryFish = {}
}

function Enemies:init()
    self.width = 16
    self.height = 16
    self.minDepth = -1000
    self.maxDepth = 1000
    self.angryFish = require('things/angryFish')
end

function Enemies:update(dt)
    for i=0,self.maxDepth do
        if not(self.list[i] == nil) then
            self.list[i]:update(dt)
        end
    end
end

function Enemies:draw(currDepth)
    love.graphics.setColor(255-darkness,0,0)
    for i=math.floor(currDepth-2000),self.maxDepth do
        if not(self.list[i] == nil) then
            self.list[i]:draw(currDepth)
        end
    end
end

function Enemies:addEnemies(currDepth)
    if currDepth+1000 >= self.maxDepth then
        self.minDepth = self.minDepth + 2000
        self.maxDepth = self.maxDepth + 2000
        for i=1,10 do
            local enemyX = math.floor(math.random(playFieldXMin,playFieldXMax))
            local enemyDepth = math.floor(math.random(self.minDepth, self.maxDepth))
            local enemy = self.angryFish()
            enemy.x = enemyX
            enemy.depth = enemyDepth
            enemy.speed = enemy.speed + enemyDepth/10000
            if enemy.speed >= 10 then enemy.speed = 10 end
            self.list[enemyDepth] = enemy
        end
    end
end

function Enemies:clearEnemies()
    self.list = {}
    self.minDepth = Diver.depthMin - 1000
    self.maxDepth = Diver.depthMin + 1000
end

function Enemies:checkCollisions(diverX, diverY, diverDepth, diverWidth, diverHeight)
    local score = 0
    diverDepthY = diverDepth - (3*screenHeight/4 - diverY)
    for i=math.floor(diverDepthY)-self.height,math.floor(diverDepthY)+diverHeight do
        local enemy = self.list[i]
        if not(enemy == nil) and diverX <= enemy.x + enemy.width and enemy.x <= diverX+diverWidth then
            if self.minDepth >= 25000 then
                Diver.health = Diver.health - 1
                coinsInPurse = coinsInPurse - 100
            elseif self.minDepth >= 10000 then
                Diver.health = Diver.health - 1
                coinsInPurse = coinsInPurse - 50
            else
                Diver.health = Diver.health - 1
            end
            self.list[i] = nil
        end
    end
    return score
end

return Enemies
