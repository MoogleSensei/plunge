local PlayState      = Class({})
-- local unleashSFX = love.audio.newSource("assets/unleash.wav", "static")
-- local shakeSFX = love.audio.newSource("assets/shake.wav", "static")
-- local asplodeSFX = love.audio.newSource("assets/asplode.wav", "static")
-- local spraySFX = love.audio.newSource("assets/spray.wav", "static")
screenWidth = love.graphics:getWidth()
screenHeight = love.graphics:getHeight()
imgBackground = love.graphics.newImage('assets/background.png')
imgDepthGauge = love.graphics.newImage('assets/depthGauge.png')
playFieldXMin = 100
playFieldXMax = 900
darkness = 0

local coinsInPurse = 0
local coinsInBank = 0
local Diver = require('things/diver')
local Enemies = require('things/enemies')
local Treasures = require('things/treasures')

function PlayState:enter(previous)
    Diver:init()
    Enemies:init()
    Enemies:addEnemies(Diver.depth)
    Treasures:init()
    Treasures:addTreasures(Diver.depth)
end

function PlayState:update(dt)
    if Diver.depth == 0 and               0 <= Diver.x and Diver.x <= screenWidth/5 then
        GameState.push(QuitState)
        Diver:init()
    end
    if Diver.depth == 0 and   screenWidth/5 <= Diver.x and Diver.x <= 4*screenWidth/5 then
        PlayState:depositCoins(coinsInPurse)
    end
    if Diver.depth == 0 and 4*screenWidth/5 <= Diver.x and Diver.x <= screenWidth then
        GameState.push(MenuState)
        Diver:init()
    end
    Diver:update(dt)
    Enemies:addEnemies(Diver.depth)
    Enemies:update(dt)

    coinsInPurse = coinsInPurse + Enemies:checkCollisions(Diver.x, Diver.y, Diver.depth, Diver.width, Diver.height)
    Treasures:addTreasures(Diver.depth)
    coinsInPurse = coinsInPurse + Treasures:checkCollisions(Diver.x, Diver.y, Diver.depth, Diver.width, Diver.height)
    if coinsInPurse <= 0 then coinsInPurse = 0 end

    darkness = math.floor(Diver.depth/100)
    if darkness >= 205 then darkness = 205 end
end

function PlayState:draw()
    love.graphics.setFont(font14)
    love.graphics.setColor(255-darkness,255-darkness,255-darkness)
    PlayState:ProcessImageForParallax(imgBackground,2,false)
    PlayState:ProcessImageForParallax(imgDepthGauge,1,true)
    -- self.cam:attach()
    Diver:draw()
    Enemies:draw(Diver.depth)
    Treasures:draw(Diver.depth)
    -- self.cam:detach()
    love.graphics.setColor(0,255,0)
    love.graphics.printf("Treasure collected: "..coinsInPurse,0,0,screenWidth/2)
    love.graphics.printf("Total Treasure: "..coinsInBank,screenWidth/2,0,screenWidth/2)
end

function PlayState:ProcessImageForParallax(img, parallaxRate, isGauge)
    local imgHeight = img:getHeight()
    local effectiveDepth = Diver.depth/parallaxRate
    local loopStart = math.floor(effectiveDepth/imgHeight) - 1
    if loopStart <= 0 then
        loopStart = 0
    end
    local loopEnd = loopStart + 2
    for i=loopStart,loopEnd do
            love.graphics.setColor(255-darkness,255-darkness,255-darkness)
        love.graphics.draw(img, 0, -screenHeight/2 - (effectiveDepth - 3*screenHeight/4) + i*imgHeight, 0, 1, 1)
        if isGauge then
            love.graphics.setColor(0,0,0)
            for j=0,9 do
                love.graphics.print(10*(j+10*i), 25, -screenHeight/2 - (effectiveDepth - 3*screenHeight/4) + i*imgHeight + 100*j - 10, 0, 1.5)
            end
        end
    end
end

function PlayState:depositCoins(coins)
    coinsInBank = coinsInBank + coins
    coinsInPurse = 0
end

function PlayState:keypressed(key)
    if key == 'a' or key == 'left'  then Diver:startDive(-1) end
    if key == 'd' or key == 'right' then Diver:startDive(1) end
    -- if key == 'a' then Diver:movePlayer('l') end
    -- if key == 's' then Diver:movePlayer('d') end
    -- if key == 'd' then Diver:movePlayer('r') end
    -- if key == 'w' then Diver:movePlayer('u') end
end

function PlayState:keyreleased(key)
    -- if key == 'escape'              then self:enterMenu() end
    if key == 'a' or key == 'left'  then Diver:endDive(-1) end
    if key == 'd' or key == 'right' then Diver:endDive(1) end
end

function PlayState:mousepressed(x, y, button)
    if button == "l" then Diver:startDive(-1) end
    if button == "r" then Diver:startDive(1) end
end

function PlayState:mousereleased(x, y, button)
    if button == "l" then Diver:endDive(-1) end
    if button == "r" then Diver:endDive(1) end
end

return PlayState
