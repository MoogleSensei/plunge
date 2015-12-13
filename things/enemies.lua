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
    for i=1,1000000 do
        if not(self.list[i] == nil) then
            self.list[i]:update(dt)
        end
    end
end

function Enemies:draw(currDepth)
    love.graphics.setColor(255-darkness,0,0)
    for i=1,1000000 do
        if not(self.list[i] == nil) then
            self.list[i]:draw(currDepth)
        end
    end
end

function Enemies:addEnemies(currDepth)
    if currDepth >= self.maxDepth then
        self.minDepth = self.minDepth + 2000
        self.maxDepth = self.maxDepth + 2000
        for i=1,10 do
            local enemyX = math.floor(math.random(playFieldXMin,playFieldXMax))
            local enemyDepth = math.floor(math.random(self.minDepth, self.maxDepth))
            local enemy = self.angryFish()
            -- enemy:init()
            enemy.x = enemyX
            enemy.depth = enemyDepth
            -- print(enemy.depth)
            self.list[enemyDepth] = enemy
        end
    end
end

function Enemies:checkCollisions(diverX, diverY, diverDepth, diverWidth, diverHeight)
    local score = 0
    diverDepthY = diverDepth - (3*screenHeight/4 - diverY)
    for i=math.floor(diverDepthY)-self.height,math.floor(diverDepthY)+diverHeight do
        if not(self.list[i] == nil) and diverX <= self.list[i].x + self.list[i].width and self.list[i].x <= diverX+diverWidth then
            -- if diverX <= self.list[i].x then self.list[i]:move(-1,3*diverWidth) end
            -- if diverX > self.list[i].x then self.list[i]:move(1,3*diverWidth) end
            self.list[i] = nil
            score = score - 10
        end
    end
    return score
end

return Enemies
