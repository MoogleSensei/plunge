local PlayState      = Class({})

screenWidth = love.graphics:getWidth()
screenHeight = love.graphics:getHeight()
imgBackground = love.graphics.newImage('assets/background.png')
imgDepthGauge = love.graphics.newImage('assets/depthGauge.png')
imgBoats = love.graphics.newImage('assets/boats.png')
imgSubmarines = love.graphics.newImage('assets/submarines.png')
playFieldXMin = 100
playFieldXMax = screenWidth-100
darkness = 0

coinsInPurse = 0
coinsInBank = 0
infinitePlay = false
Diver = require('things/diver')
local Enemies = require('things/enemies')
local Treasures = require('things/treasures')

function PlayState:enter(previous)
    infinitePlay = false
    coinsInPurse = 0
    coinsInBank = 0
    Diver:init()
    Enemies:init()
    Enemies:addEnemies(Diver.depth)
    Treasures:init()
    Treasures:addTreasures(Diver.depth)
end

function PlayState:update(dt)
    if Diver.depth == Diver.depthMin and               0 <= Diver.x and Diver.x <= screenWidth/5 then
        PlayState:depositCoins(coinsInPurse)
        if coinsInBank < 1000000 or infinitePlay then
            GameState.push(QuitState)
            Diver.x,Diver.y = screenWidth/2-Diver.width/2, screenHeight/4
            Diver.health = Diver.healthMax
            Enemies:clearEnemies()
            Treasures:clearTreasures()
        end
    end
    if Diver.depth == Diver.depthMin and   screenWidth/5 <= Diver.x and Diver.x <= 4*screenWidth/5 then
        PlayState:depositCoins(coinsInPurse)
        Diver.health = Diver.healthMax
        Enemies:clearEnemies()
        Treasures:clearTreasures()
    end
    if Diver.depth == Diver.depthMin and 4*screenWidth/5 <= Diver.x and Diver.x <= screenWidth then
        PlayState:depositCoins(coinsInPurse)
        if coinsInBank < 1000000 or infinitePlay then
            GameState.push(MenuState)
            Diver.x,Diver.y = screenWidth/2-Diver.width/2, screenHeight/4
            Diver.health = Diver.healthMax
            Enemies:clearEnemies()
            Treasures:clearTreasures()
        end
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
    if Diver.depthMin == 0 then
        love.graphics.setColor(255-darkness,255-darkness,255-darkness)
        love.graphics.draw(imgBoats, 0, -Diver.depth/2, 0, 1, 1)
        love.graphics.setColor(0,0,0,128)
        love.graphics.line(screenWidth/5, screenHeight/4-Diver.depth/2, screenWidth/5, 3*screenHeight/4-Diver.depth/2)
        love.graphics.line(4*screenWidth/5, screenHeight/4-Diver.depth/2, 4*screenWidth/5, 3*screenHeight/4-Diver.depth/2)
        love.graphics.setColor(0,0,0,64)
        love.graphics.setFont(font48)
        love.graphics.printf("Rise to quit",1*screenWidth/10,screenHeight/4-Diver.depth/2,3*screenHeight/4,'left',2*math.pi/5)
        love.graphics.printf("Rise to upgrade",9*screenWidth/10-36,screenHeight/4-Diver.depth/2,3*screenHeight/4,'left',2*math.pi/5)
    else
        love.graphics.setColor(255-darkness,255-darkness,255-darkness)
        love.graphics.draw(imgSubmarines, 0, Diver.depthMin/2 - Diver.depth/2, 0, 1, 1)
        love.graphics.setColor(0,0,0,128)
        love.graphics.line(screenWidth/5, screenHeight/4-Diver.depth/2, screenWidth/5, 3*screenHeight/4-Diver.depth/2)
        love.graphics.line(4*screenWidth/5, screenHeight/4-Diver.depth/2, 4*screenWidth/5, 3*screenHeight/4-Diver.depth/2)

    end
    Enemies:draw(Diver.depth)
    Treasures:draw(Diver.depth)
    Diver:draw()
    love.graphics.setFont(font14)
    love.graphics.setColor(200,200,0)
    love.graphics.printf("Treasure: "..coinsInPurse,0,0,screenWidth/5,'left')
    love.graphics.printf("Total Treasure: "..coinsInBank,4*screenWidth/5,0,screenWidth/5,'right')
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
    if coinsInBank >= 1000000 and not(infinitePlay) then
        GameState.push(VictoryState)
        -- infinitePlay = true
    end
end

function PlayState:keypressed(key)
    if Diver.isAlive then
        if key == 'a' or key == 'left'  then Diver:startDive(-1) end
        if key == 'd' or key == 'right' then Diver:startDive(1) end
        -- if key == 'y' then coinsInPurse = coinsInPurse + 100000 end
    end
end

function PlayState:keyreleased(key)
    if Diver.isAlive then
        if key == 'a' or key == 'left'  then Diver:endDive(-1) end
        if key == 'd' or key == 'right' then Diver:endDive(1) end
    else
        if Diver.deathTimer >= 1 then
            if key == 'a' or key == 'left'  then love.event.quit() end
            if key == 'd' or key == 'right' then GameState.switch(PlayState) end
        end
    end
end

function PlayState:mousepressed(x, y, button)
    if Diver.isAlive then
        if button == 'l' then Diver:startDive(-1) end
        if button == 'r' then Diver:startDive(1) end
    end
end

function PlayState:mousereleased(x, y, button)
    if Diver.isAlive then
        if button == 'l' then Diver:endDive(-1) end
        if button == 'r' then Diver:endDive(1) end
    else
        if Diver.deathTimer >= 1 then
            if button == 'l' then love.event.quit() end
            if button == 'r' then GameState.switch(PlayState) end
        end
    end
end

return PlayState
