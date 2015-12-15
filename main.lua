-- PLUNGE
-- Ludum Dare 34
-- 
-- Written by Sean Miller
-- 12/11/2015
-- 
-- This is my 72 hour Ludum Dare 34 Jam entry.
-- It's for my third Ludum Dare, though I usually do the Compo, not the Jam.
-- Conflicts throughout the weekend prevented me from giving it all my attention, but I have done what I could.
-- Unfortunately I lacked to time/skill/motivation to do any semi-decent graphics or sound at all. Perhaps they will be added later.
Class				= require('hump/class')
GameState 			= require('hump/gamestate')
TitleState 	        = require('states/titleState')
HowToState 	        = require('states/howToState')
PlayState 			= require('states/playState')
QuitState 			= require('states/quitState')
MenuState           = require('states/menuState')
VictoryState 		= require('states/victoryState')

font14 = love.graphics.newFont(14)
font24 = love.graphics.newFont(24)
font48 = love.graphics.newFont(48)
font72 = love.graphics.newFont(72)

function love.load()
	GameState.registerEvents()
	GameState.switch(TitleState)
end

function love.update(dt) end

function love.draw() end

function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end
function math.round(n, deci) deci = 10^(deci or 0) return math.floor(n*deci+.5)/deci end
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end
