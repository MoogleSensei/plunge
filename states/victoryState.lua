local VictoryState       = Class({})

local selectTimer = 0
local selectTimerMax = 0

function VictoryState:enter(previous)
    selectTimer = 0
    selectTimerMax = 0
end

function VictoryState:update(dt)
    selectTimer = selectTimer + dt
end

function VictoryState:draw()
    love.graphics.setColor(128,0,0)
    love.graphics.rectangle('fill',0,3*screenHeight/4,screenWidth/2,screenHeight/4)
    love.graphics.setColor(0,128,0)
    love.graphics.rectangle('fill',screenWidth/2,3*screenHeight/4,screenWidth/2,screenHeight/4)

    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font72)
    love.graphics.printf("You win!\nKeep playing?",0,screenHeight/4,screenWidth,'center')

    love.graphics.setFont(font48)
    love.graphics.printf("No thanks.",0,7*screenHeight/8,screenWidth/2,'center')
    love.graphics.printf("YES!",screenWidth/2,7*screenHeight/8,screenWidth/2,'center')

    love.graphics.setFont(font14)
    love.graphics.printf("(Left to...)",0,13*screenHeight/16,screenWidth/2,'center')
    love.graphics.printf("(Right to...)",screenWidth/2,13*screenHeight/16,screenWidth/2,'center')
end

function VictoryState:keyreleased(key)
    if selectTimer >= selectTimerMax then
        if key == 'a' or key == 'left'  then love.event.quit() end
        if key == 'd' or key == 'right' then GameState.pop() end
    end
end

function VictoryState:mousereleased(x, y, button)
    if selectTimer >= selectTimerMax then
        if button == "l" then love.event.quit() end
        if button == "r" then GameState.pop() end
    end
end

return VictoryState
