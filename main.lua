-- PLUNGE
-- Ludum Dare 34
-- 
-- Written by Sean Miller
-- 12/11/2015
-- 
-- This is my 72 hour Ludum Dare 34 Jam entry.
-- It's for my third Ludum Dare, though I usually do the Compo, not the Jam.
-- I still did it in ~48 hours, I just had several conflicts throughout the weekend that prevented me from doing it in 48 consecutive hours.
HC					= require('HC')
Class				= require('hump/class')
GameState 			= require('hump/gamestate')
-- TitleState 	= require('states/startScreenState')
PlayState 			= require('states/playState')
-- ChooseColorState 	= require('states/chooseColorState')
-- LevelState			= require('states/levelState')
-- MenuState 			= require('states/menuState')
-- NextLevelState 		= require('states/nextLevelState')
-- VictoryState 		= require('states/victoryState')
-- globalVolume		= 1	-- Initially volume set at 100%
-- musicSFX 			= love.audio.newSource("assets/music.wav", "static")
-- musicSFX:setLooping(true)
-- musicSFX:setVolume(globalVolume)
-- coughSFX 			= love.audio.newSource("assets/cough.wav", "static")
-- chooseMusic			= true

function love.load()
	GameState.registerEvents()
	GameState.switch(PlayState)
end

function love.update(dt) end

function love.draw() end

function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end
function math.round(n, deci) deci = 10^(deci or 0) return math.floor(n*deci+.5)/deci end
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function gradient(colors)
    local direction = colors.direction or "horizontal"
    if direction == "horizontal" then
        direction = true
    elseif direction == "vertical" then
        direction = false
    else
        error("Invalid direction '" .. tostring(direction) "' for gradient.  Horizontal or vertical expected.")
    end
    local result = love.image.newImageData(direction and 1 or #colors, direction and #colors or 1)
    for i, color in ipairs(colors) do
        local x, y
        if direction then
            x, y = 0, i - 1
        else
            x, y = i - 1, 0
        end
        result:setPixel(x, y, color[1], color[2], color[3], color[4] or 255)
    end
    result = love.graphics.newImage(result)
    result:setFilter('linear', 'linear')
    return result
end
