local QuitState       = Class({})

local selectTimer = 0
local selectTimerMax = 0

function QuitState:enter(previous)
    selectTimer = 0
    selectTimerMax = 0
end

function QuitState:update(dt)
    selectTimer = selectTimer + dt
end

function QuitState:draw()
    love.graphics.setColor(128,0,0)
    love.graphics.rectangle('fill',0,3*screenHeight/4,screenWidth/2,screenHeight/4)
    love.graphics.setColor(0,128,0)
    love.graphics.rectangle('fill',screenWidth/2,3*screenHeight/4,screenWidth/2,screenHeight/4)
    love.graphics.setColor(255,255,255)

    love.graphics.setFont(font72)
    love.graphics.printf("Really quit?",0,screenHeight/4,screenWidth,'center')

    love.graphics.setFont(font48)
    love.graphics.printf("NO!",0,7*screenHeight/8,screenWidth/2,'center')
    love.graphics.printf("Yes...",screenWidth/2,7*screenHeight/8,screenWidth/2,'center')

    love.graphics.setFont(font14)
    love.graphics.printf("(Left to...)",0,13*screenHeight/16,screenWidth/2,'center')
    love.graphics.printf("(Right to...)",screenWidth/2,13*screenHeight/16,screenWidth/2,'center')
end

function QuitState:keyreleased(key)
    if selectTimer >= selectTimerMax then
        if key == 'a' or key == 'left'  then GameState.pop() end
        if key == 'd' or key == 'right' then love.event.quit() end
    end
end

function QuitState:mousereleased(x, y, button)
    if selectTimer >= selectTimerMax then
        if button == "l" then GameState.pop() end
        if button == "r" then love.event.quit() end
    end
end

return QuitState
