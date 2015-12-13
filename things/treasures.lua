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
    for i=1,1000000 do
        if not(self.list[i] == nil) then
            love.graphics.rectangle("fill",self.list[i],i - (currDepth - 3*screenHeight/4),self.width,self.height)
        end
    end
    -- for i,v in ipairs(self.list) do
    --     love.graphics.rectangle("fill",self.list[i],i - (currDepth - 3*screenHeight/4),self.width,self.height)
    -- end
end

function Treasures:addTreasures(currDepth)
    if currDepth >= self.maxDepth then
        self.minDepth = self.minDepth + 2000
        self.maxDepth = self.maxDepth + 2000
        for i=1,20 do
            local treasX = math.floor(math.random(playFieldXMin,playFieldXMax))
            local treasY = math.floor(math.random(self.minDepth, self.maxDepth))
            self.list[treasY] = treasX
        end
    end
end

function Treasures:checkCollisions(diverX, diverY, diverDepth, diverWidth, diverHeight)
    local score = 0
    diverDepthY = diverDepth - (3*screenHeight/4 - diverY)
    for i=math.floor(diverDepthY)-self.height,math.floor(diverDepthY)+diverHeight do
        if not(self.list[i] == nil) and diverX <= self.list[i] + self.width and self.list[i] <= diverX+diverWidth then
            self.list[i] = nil
            score = score + math.ceil(diverDepthY/1000)
        end
    end
    return score
end

return Treasures
