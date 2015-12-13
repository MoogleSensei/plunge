local MenuState       = Class({})

-- local optionBack = require('things/optionBack')
-- local optionUpgradeTank = require('things/optionUpgradeTank')
-- local optionUpgradeFlippers = require('things/optionUpgradeFlippers')
-- local optionUpgradeSubmarine = require('things/optionUpgradeSubmarine')
-- local optionUpgradeArmor = require('things/optionUpgradeArmor')
-- local optionVolume = require('things/optionVolume')

local currentOption = "Back"
local nextOption = "Upgrade Tank"

function MenuState:enter(previous)
end

function MenuState:update(dt)
end

function MenuState:draw()
    love.graphics.setColor(128,0,128)
    love.graphics.rectangle('fill',0,3*screenHeight/4,screenWidth/2,screenHeight/4)
    love.graphics.setColor(0,128,0)
    love.graphics.rectangle('fill',screenWidth/2,3*screenHeight/4,screenWidth/2,screenHeight/4)
    love.graphics.setColor(255,255,255)
    love.graphics.push()
        love.graphics.setFont(font72)
        love.graphics.printf(currentOption,screenWidth/2,screenHeight/2,screenWidth/2,'center')
        love.graphics.setFont(font24)
        love.graphics.printf("Cycle options",0,7*screenHeight/8,screenWidth/2,'center')
        love.graphics.printf("Select option",screenWidth/2,7*screenHeight/8,screenWidth/2,'center')
    love.graphics.pop()
end

function MenuState:cycleOption()
    currentOption = nextOption
    if currentOption == "Back" then nextOption = "Upgrade Tank" end
    if currentOption == "Upgrade Tank" then nextOption = "Upgrade Flippers" end
    if currentOption == "Upgrade Flippers" then nextOption = "Upgrade Submarine" end
    if currentOption == "Upgrade Submarine" then nextOption = "Upgrade Armor" end
    if currentOption == "Upgrade Armor" then nextOption = "Back" end
end

function MenuState:selectOption()
    if currentOption == "Back" then GameState.pop() end
    if currentOption == "Upgrade Tank" then print(currentOption) end
    if currentOption == "Upgrade Flippers" then print(currentOption) end
    if currentOption == "Upgrade Submarine" then print(currentOption) end
    if currentOption == "Upgrade Armor" then print(currentOption) end
end

function MenuState:keyreleased(key)
    if key == 'a' or key == 'left'  then MenuState:cycleOption() end
    if key == 'd' or key == 'right' then MenuState:selectOption() end
end

function MenuState:mousereleased(x, y, button)
    if button == "l" then MenuState:cycleOption() end
    if button == "r" then MenuState:selectOption() end
end

return MenuState
