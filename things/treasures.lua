local Treasures      = Class{
    list = {},
    width = 0,
    height = 0,
    minDepth = 0,
    maxDepth = 0
}

function Treasures:init()
    self.width = 8
    self.height = 8
    self.minDepth = -1000
    self.maxDepth = 1000
end

function Treasures:update(dt)
end

function Treasures:draw(currDepth)
    love.graphics.setColor(255-darkness,255-darkness,0)
    for i=math.floor(currDepth-2000),self.maxDepth do
        if not(self.list[i] == nil) then
            love.graphics.rectangle("fill",self.list[i],i - (currDepth - 3*screenHeight/4),self.width,self.height)
        end
    end
end

function Treasures:addTreasures(currDepth)
    if currDepth+1000 >= self.maxDepth then
        self.minDepth = self.minDepth + 2000
        self.maxDepth = self.maxDepth + 2000
        local countMultiplier = 1
        if self.minDepth >= 200000 then
            countMultiplier = 500
        elseif self.minDepth >= 100000 then
            countMultiplier = 100
        elseif self.minDepth >= 50000 then
            countMultiplier = 8
        elseif self.minDepth >= 25000 then
            countMultiplier = 5
        elseif self.minDepth >= 10000 then
            countMultiplier = 2
        end
        for i=1,10*countMultiplier do
            local treasX = math.floor(math.random(playFieldXMin,playFieldXMax))
            local treasY = math.floor(math.random(self.minDepth, self.maxDepth))
            self.list[treasY] = treasX
        end
    end
end

function Treasures:clearTreasures()
    self.list = {}
    self.minDepth = Diver.depthMin - 1000
    self.maxDepth = Diver.depthMin + 1000
end

function Treasures:checkCollisions(diverX, diverY, diverDepth, diverWidth, diverHeight)
    local score = 0
    diverDepthY = diverDepth - (3*screenHeight/4 - diverY)
    for i=math.floor(diverDepthY)-self.height,math.floor(diverDepthY)+diverHeight do
        if not(self.list[i] == nil) and diverX <= self.list[i] + self.width and self.list[i] <= diverX+diverWidth then
            self.list[i] = nil
            score = score + math.ceil(diverDepthY/500)*Diver.upgradeSubmarine
        end
    end
    return score
end

return Treasures
