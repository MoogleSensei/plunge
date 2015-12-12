local PlayState     = Class({})
-- local unleashSFX = love.audio.newSource("assets/unleash.wav", "static")
-- local shakeSFX = love.audio.newSource("assets/shake.wav", "static")
-- local asplodeSFX = love.audio.newSource("assets/asplode.wav", "static")
-- local spraySFX = love.audio.newSource("assets/spray.wav", "static")
screenWidth = love.graphics:getWidth()
screenHeight = love.graphics:getHeight()
background = love.graphics.newImage('assets/background.png')


local Diver = require('things/Diver')

function PlayState:enter(previous, level, monsterColour, score)
    Diver:init()
end

function PlayState:update(dt)
    Diver:update(dt)
end

function PlayState:draw()
    love.graphics.setColor(255,255,255)
    PlayState:ProcessImageForParallax(background)
    -- if Diver.depth <= 3*screenHeight/4 then
    --     love.graphics.draw(background, 0, 0, 0, 1, 1)
    -- elseif Diver.depth - 3*screenHeight/4 <= imgHeight then
    --     love.graphics.draw(background, 0, -(Diver.depth - 3*screenHeight/4), 0, 1, 1)
    --     if Diver.depth + screenHeight/4 >= imgHeight and Diver.depth - 3*screenHeight/4 <= 2*imgHeight then
    --         love.graphics.draw(background, 0, -(Diver.depth - 3*screenHeight/4) + imgHeight, 0, 1, 1)
    --     end
    -- else
    --     loopStart = math.floor(Diver.depth/imgHeight) - 1
    --     loopEnd = loopStart + 3
    --     for i=loopStart,loopEnd do
    --         if Diver.depth + screenHeight/4 >= i*imgHeight and Diver.depth - 3*screenHeight/4 <= (i+1)*imgHeight then
    --             love.graphics.draw(background, 0, -(Diver.depth - 3*screenHeight/4) + i*imgHeight, 0, 1, 1)
    --         end
    --     end
    -- end
    -- self.cam:attach()
    Diver:draw()
    -- self.cam:detach()
    love.graphics.setColor(0,255,0)
    love.graphics.print("LEVEL "..Diver.depth,0,0,0,1.5)
end

function PlayState:ProcessImageForParallax(img)
    imgHeight = img:getHeight()
    if Diver.depth <= 3*screenHeight/4 then
        love.graphics.draw(img, 0, 0, 0, 1, 1)
    elseif Diver.depth - 3*screenHeight/4 <= imgHeight then
        love.graphics.draw(img, 0, -(Diver.depth - 3*screenHeight/4), 0, 1, 1)
        if Diver.depth + screenHeight/4 >= imgHeight and Diver.depth - 3*screenHeight/4 <= 2*imgHeight then
            love.graphics.draw(img, 0, -(Diver.depth - 3*screenHeight/4) + imgHeight, 0, 1, 1)
        end
    else
        loopStart = math.floor(Diver.depth/imgHeight) - 1
        loopEnd = loopStart + 3
        for i=loopStart,loopEnd do
            if Diver.depth + screenHeight/4 >= i*imgHeight and Diver.depth - 3*screenHeight/4 <= (i+1)*imgHeight then
                love.graphics.draw(img, 0, -(Diver.depth - 3*screenHeight/4) + i*imgHeight, 0, 1, 1)
            end
        end
    end
end

function PlayState:enterMenu()
    -- GameState.push(MenuState)
end

function PlayState:keypressed(key)
    if key == 'a' or key == 'left'  then Diver:movePlayer(-1) end
    if key == 'd' or key == 'right' then Diver:movePlayer(1) end
end

function PlayState:keyreleased(key)
    -- if key == 'escape'              then self:enterMenu() end
    if key == 'a' or key == 'left'  then Diver:movePlayer(-1) end
    if key == 'd' or key == 'right' then Diver:movePlayer(1) end
end

function PlayState:mousepressed(x, y, button)
    if button == "l" then Diver:movePlayer(-1) end
    if button == "r" then Diver:movePlayer(1) end
end

function PlayState:mousereleased(x, y, button)
    if button == "l" then Diver:movePlayer(-1) end
    if button == "r" then Diver:movePlayer(1) end
end

function PlayState:focus(f)
    if not f then
        -- GameState.push(MenuState)
    end
end

return PlayState
