local MenuState       = Class({})

local selectTimer = 0
local selectTimerMax = 0
local currentOption = "Go Back"
local nextOption = "Upgrade Tank"
local colourOffset = 0

function MenuState:enter(previous)
    selectTimer = 0
    selectTimerMax = 0
end

function MenuState:update(dt)
    selectTimer = selectTimer + dt
end

function MenuState:draw()
    if currentOption == "Upgrade Tank" then
        colourOffset = 127
    else
        colourOffset = 0
    end
    love.graphics.setColor(96,96,96,128+colourOffset)
    love.graphics.rectangle('fill',0,24,screenWidth/4,(3*screenHeight/4-24-64)/4)
    love.graphics.setColor(32,32,32,128+colourOffset)
    love.graphics.rectangle('line',0,24,screenWidth/4,(3*screenHeight/4-24-64)/4)
    love.graphics.setColor(255,255,255,128+colourOffset)
    love.graphics.setFont(font24)
    love.graphics.printf("Upgrade Tank",0,24+20,screenWidth/4,'center')
    love.graphics.setFont(font14)
    love.graphics.printf("Current Level:\n"..Diver.upgradeTank.."/"..Diver.upgradeTankMax,0,24+20+32,screenWidth/4,'center')
    love.graphics.printf("Current Cost:\n"..Diver.upgradeTankCost,0,24+20+32+32,screenWidth/4,'center')

    if currentOption == "Upgrade Flippers" then
        colourOffset = 127
    else
        colourOffset = 0
    end
    love.graphics.setColor(96,96,96,128+colourOffset)
    love.graphics.rectangle('fill',0,24+(3*screenHeight/4-24-64)/4,screenWidth/4,(3*screenHeight/4-24-64)/4)
    love.graphics.setColor(32,32,32,128+colourOffset)
    love.graphics.rectangle('line',0,24+(3*screenHeight/4-24-64)/4,screenWidth/4,(3*screenHeight/4-24-64)/4)
    love.graphics.setColor(255,255,255,128+colourOffset)
    love.graphics.setFont(font24)
    love.graphics.printf("Upgrade Flippers",0,24+(3*screenHeight/4-24-64)/4+20,screenWidth/4,'center')
    love.graphics.setFont(font14)
    love.graphics.printf("Current Level:\n"..Diver.upgradeFlippers.."/"..Diver.upgradeFlippersMax,0,24+(3*screenHeight/4-24-64)/4+20+32,screenWidth/4,'center')
    love.graphics.printf("Current Cost:\n"..Diver.upgradeFlippersCost,0,24+(3*screenHeight/4-24-64)/4+20+32+32,screenWidth/4,'center')

    if currentOption == "Upgrade Submarine" then
        colourOffset = 127
    else
        colourOffset = 0
    end
    love.graphics.setColor(96,96,96,128+colourOffset)
    love.graphics.rectangle('fill',0,24+2*(3*screenHeight/4-24-64)/4,screenWidth/4,(3*screenHeight/4-24-64)/4)
    love.graphics.setColor(32,32,32,128+colourOffset)
    love.graphics.rectangle('line',0,24+2*(3*screenHeight/4-24-64)/4,screenWidth/4,(3*screenHeight/4-24-64)/4)
    love.graphics.setColor(255,255,255,128+colourOffset)
    love.graphics.setFont(font24)
    love.graphics.printf("Upgrade Submarine",0,24+2*(3*screenHeight/4-24-64)/4+20,screenWidth/4,'center')
    love.graphics.setFont(font14)
    love.graphics.printf("Current Level:\n"..Diver.upgradeSubmarine.."/"..Diver.upgradeSubmarineMax,0,24+2*(3*screenHeight/4-24-64)/4+20+32,screenWidth/4,'center')
    love.graphics.printf("Current Cost:\n"..Diver.upgradeSubmarineCost,0,24+2*(3*screenHeight/4-24-64)/4+20+32+32,screenWidth/4,'center')

    if currentOption == "Upgrade Armor" then
        colourOffset = 127
    else
        colourOffset = 0
    end
    love.graphics.setColor(96,96,96,128+colourOffset)
    love.graphics.rectangle('fill',0,24+3*(3*screenHeight/4-24-64)/4,screenWidth/4,(3*screenHeight/4-24-64)/4)
    love.graphics.setColor(32,32,32,128+colourOffset)
    love.graphics.rectangle('line',0,24+3*(3*screenHeight/4-24-64)/4,screenWidth/4,(3*screenHeight/4-24-64)/4)
    love.graphics.setColor(255,255,255,128+colourOffset)
    love.graphics.setFont(font24)
    love.graphics.printf("Upgrade Armor",0,24+3*(3*screenHeight/4-24-64)/4+20,screenWidth/4,'center')
    love.graphics.setFont(font14)
    love.graphics.printf("Current Level:\n"..Diver.upgradeArmor.."/"..Diver.upgradeArmorMax,0,24+3*(3*screenHeight/4-24-64)/4+20+32,screenWidth/4,'center')
    love.graphics.printf("Current Cost:\n"..Diver.upgradeArmorCost,0,24+3*(3*screenHeight/4-24-64)/4+20+32+32,screenWidth/4,'center')

    if currentOption == "Go Back" then
        colourOffset = 127
    else
        colourOffset = 0
    end
    love.graphics.setColor(96,96,96,128+colourOffset)
    love.graphics.rectangle('fill',0,24+4*(3*screenHeight/4-24-64)/4,screenWidth/4,64)
    love.graphics.setColor(32,32,32,128+colourOffset)
    love.graphics.rectangle('line',0,24+4*(3*screenHeight/4-24-64)/4,screenWidth/4,64)
    love.graphics.setColor(255,255,255,128+colourOffset)
    love.graphics.setFont(font24)
    love.graphics.printf("Go Back",0,24+4*(3*screenHeight/4-24-64)/4+20,screenWidth/4,'center')

    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font72)
    love.graphics.printf(currentOption,screenWidth/4,24,3*screenWidth/4,'center')

    love.graphics.setColor(200,200,0)
    love.graphics.setFont(font14)
    love.graphics.printf("Total Treasure: "..coinsInBank,0,5,screenWidth/4,'center')

    love.graphics.setColor(128,0,128)
    love.graphics.rectangle('fill',0,3*screenHeight/4,screenWidth/2,screenHeight/4)
    love.graphics.setColor(0,128,0)
    love.graphics.rectangle('fill',screenWidth/2,3*screenHeight/4,screenWidth/2,screenHeight/4)

    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font48)
    love.graphics.printf("Cycle options",0,7*screenHeight/8,screenWidth/2,'center')
    love.graphics.printf(currentOption,screenWidth/2,7*screenHeight/8,screenWidth/2,'center')

    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font14)
    love.graphics.printf("(Left to...)",0,13*screenHeight/16,screenWidth/2,'center')
    love.graphics.printf("(Right to...)",screenWidth/2,13*screenHeight/16,screenWidth/2,'center')
end

function MenuState:cycleOption()
    currentOption = nextOption
    if currentOption == "Go Back" then nextOption = "Upgrade Tank" end
    if currentOption == "Upgrade Tank" then nextOption = "Upgrade Flippers" end
    if currentOption == "Upgrade Flippers" then nextOption = "Upgrade Submarine" end
    if currentOption == "Upgrade Submarine" then nextOption = "Upgrade Armor" end
    if currentOption == "Upgrade Armor" then nextOption = "Go Back" end
end

function MenuState:selectOption()
    if currentOption == "Go Back" then
        GameState.pop()
    else
        Diver:upgrade(currentOption)
    end
end

function MenuState:keyreleased(key)
    if selectTimer >= selectTimerMax then
        if key == 'a' or key == 'left'  then MenuState:cycleOption() end
        if key == 'd' or key == 'right' then MenuState:selectOption() end
    end
end

function MenuState:mousereleased(x, y, button)
    if selectTimer >= selectTimerMax then
        if button == "l" then MenuState:cycleOption() end
        if button == "r" then MenuState:selectOption() end
    end
end

return MenuState
