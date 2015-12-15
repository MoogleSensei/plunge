local TitleState       = Class({})

local selectTimer = 0
local selectTimerMax = 0

function TitleState:enter(previous)
    selectTimer = 0
    selectTimerMax = 0
end

function TitleState:update(dt)
    selectTimer = selectTimer + dt
end

function TitleState:draw()
    love.graphics.setColor(128,0,0)
    love.graphics.rectangle('fill',0,3*screenHeight/4,screenWidth/2,screenHeight/4)
    love.graphics.setColor(0,128,0)
    love.graphics.rectangle('fill',screenWidth/2,3*screenHeight/4,screenWidth/2,screenHeight/4)

    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font72)
    love.graphics.printf("Plunge",0,screenHeight/4,screenWidth,'center')

    love.graphics.setFont(font48)
    love.graphics.printf("Exit",0,7*screenHeight/8,screenWidth/2,'center')
    love.graphics.printf("Play",screenWidth/2,7*screenHeight/8,screenWidth/2,'center')

    love.graphics.setFont(font14)
    love.graphics.printf("(Press left or 'a' or left-click to...)",0,13*screenHeight/16,screenWidth/2,'center')
    love.graphics.printf("(Press right or 'd' or right-click to...)",screenWidth/2,13*screenHeight/16,screenWidth/2,'center')
end

function TitleState:keyreleased(key)
    if selectTimer >= selectTimerMax then
        if key == 'a' or key == 'left'  then love.event.quit() end
        if key == 'd' or key == 'right' then GameState.switch(HowToState) end
    end
end

function TitleState:mousereleased(x, y, button)
    if selectTimer >= selectTimerMax then
        if button == "l" then love.event.quit() end
        if button == "r" then GameState.switch(HowToState) end
    end
end

return TitleState
