local QuitState       = Class({})
screenWidth = love.graphics:getWidth()
screenHeight = love.graphics:getHeight()

function QuitState:enter(previous)
end

function QuitState:update(dt)
end

function QuitState:draw()
    love.graphics.setColor(128,0,0)
    love.graphics.rectangle('fill',0,0,screenWidth/2,screenHeight)
    love.graphics.setColor(0,128,0)
    love.graphics.rectangle('fill',screenWidth/2,0,screenWidth/2,screenHeight)
    love.graphics.setColor(255,255,255)
    love.graphics.push()
        love.graphics.setFont(font72)
        love.graphics.printf("Really quit?",0,screenHeight/8,screenWidth,'center')
        love.graphics.setFont(font48)
        love.graphics.printf("NO!",0,screenHeight/2,screenWidth/2,'center')
        love.graphics.printf("Yes...",screenWidth/2,screenHeight/2,screenWidth/2,'center')
    love.graphics.pop()
end

function QuitState:keyreleased(key)
    if key == 'a' or key == 'left'  then GameState.pop() end
    if key == 'd' or key == 'right' then love.event.quit() end
end

function QuitState:mousereleased(x, y, button)
    if button == "l" then GameState.pop() end
    if button == "r" then love.event.quit() end
end

return QuitState
