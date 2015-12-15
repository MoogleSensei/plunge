local HowToState       = Class({})

local selectTimer = 0
local selectTimerMax = 0
local howToSteps = 0

function HowToState:enter(previous)
    selectTimer = 0
    selectTimerMax = 0
    howToSteps = 0
end

function HowToState:update(dt)
    if howToSteps < 0 then GameState.switch(TitleState) end
    if howToSteps > 3 then GameState.switch(PlayState) end
    selectTimer = selectTimer + dt
end

function HowToState:draw()
    love.graphics.setColor(128,0,0)
    love.graphics.rectangle('fill',0,3*screenHeight/4,screenWidth/2,screenHeight/4)
    love.graphics.setColor(0,128,0)
    love.graphics.rectangle('fill',screenWidth/2,3*screenHeight/4,screenWidth/2,screenHeight/4)

    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font72)
    love.graphics.printf("How to Play:",0,0,screenWidth,'center')
    if howToSteps == 0 then
        love.graphics.setFont(font24)
        love.graphics.printf("    Use the left arrow key, the 'a' key, or left-click on your mouse to select the left option when options are displayed on the bottom of the screen or to dive down and to the left during gameplay.",0,screenHeight/5,screenWidth,'center')
        love.graphics.printf("    Use the right arrow key, the 'd' key, or right-click on your mouse to select the right option when options are displayed on the bottom of the screen or to dive down and to the right during gameplay.",0,screenHeight/5+5*24,screenWidth,'center')
        love.graphics.printf("    When diving, you can press the button quickly to dive a small amount or hold it to dive longer.",0,screenHeight/5+10*24,screenWidth,'center')
    elseif howToSteps == 1 then
        love.graphics.setFont(font24)
        love.graphics.printf("    You play as the scuba-diving white square on a mission to collect 1,000,000 treasure. Your superiors have demanded you collect as least that much treasure just to make this expedition worth it, though the more you collect, the better you will be paid.",0,screenHeight/5,screenWidth,'center')
        love.graphics.printf("    Fortunately your superiors have seen fit to offer you better gear that should make collecting mountains of treasure a piece of cake! Unfortunately, it's going to cost you, and you'll be starting out with the worst gear possible.",0,screenHeight/5+5*24,screenWidth,'center')
        love.graphics.printf("    In order to shop for gear upgrades, simply float up to the surface (or to your submarine) on the right end of the screen.",0,screenHeight/5+10*24,screenWidth,'center')
    elseif howToSteps == 2 then
        love.graphics.setFont(font24)
        love.graphics.printf("    There are also hazards floating around in the water. Angry, possessive fish will bite a chunk out of you if they get close enough. The amount of health you have left will be displayed at the top of the screen.",0,screenHeight/5,screenWidth,'center')
        love.graphics.printf("    To recover precious health, simply rise to the surface in the middle of the screen. At least you are getting the best healthcare possible!",0,screenHeight/5+5*24,screenWidth,'center')
    elseif howToSteps == 3 then
        love.graphics.setFont(font24)
        love.graphics.printf("    If it all proves to be too much for you to handle, you can quit by rising to the surface in the left end of the screen.",0,screenHeight/5,screenWidth,'center')
        love.graphics.printf("    Despite all the hazards and lofty, corporate goals, try to have fun as you plunge into the depths on a great search for treasure!",0,screenHeight/5+4*24,screenWidth,'center')
    end
    love.graphics.setFont(font48)
    love.graphics.printf("Go Back",0,7*screenHeight/8,screenWidth/2,'center')
    if howToSteps == 3 then
        love.graphics.printf("Play",screenWidth/2,7*screenHeight/8,screenWidth/2,'center')
    else
        love.graphics.printf("Continue",screenWidth/2,7*screenHeight/8,screenWidth/2,'center')
    end

    love.graphics.setFont(font14)
    love.graphics.printf("(Left to...)",0,13*screenHeight/16,screenWidth/2,'center')
    love.graphics.printf("(Right to...)",screenWidth/2,13*screenHeight/16,screenWidth/2,'center')
end

function HowToState:keyreleased(key)
    if selectTimer >= selectTimerMax then
        if key == 'a' or key == 'left'  then howToSteps = howToSteps - 1 end
        if key == 'd' or key == 'right' then howToSteps = howToSteps + 1 end
    end
end

function HowToState:mousereleased(x, y, button)
    if selectTimer >= selectTimerMax then
        if button == "l" then howToSteps = howToSteps - 1 end
        if button == "r" then howToSteps = howToSteps + 1 end
    end
end

return HowToState
