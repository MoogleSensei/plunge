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
QuitState 			= require('states/quitState')
MenuState           = require('states/menuState')
-- VictoryState 		= require('states/victoryState')

-- globalVolume		= 1	-- Initially volume set at 100%
-- musicSFX 			= love.audio.newSource("assets/music.wav", "static")
-- musicSFX:setLooping(true)
-- musicSFX:setVolume(globalVolume)
-- coughSFX 			= love.audio.newSource("assets/cough.wav", "static")
-- chooseMusic			= true

font14 = love.graphics.newFont(14)
font24 = love.graphics.newFont(24)
font48 = love.graphics.newFont(48)
font72 = love.graphics.newFont(72)

function love.load()
	GameState.registerEvents()
	GameState.switch(PlayState)
end

function love.update(dt) end

function love.draw() end

function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end
function math.round(n, deci) deci = 10^(deci or 0) return math.floor(n*deci+.5)/deci end
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end
