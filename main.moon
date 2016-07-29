gamestate = require 'vendor/hump/gamestate'
TitleState = require 'lib/states/title'

love.load = () ->
	love.graphics.setNewFont(12)
	love.graphics.setBackgroundColor(0 ,0, 0)
	love.graphics.setColor(255, 255, 255)

	gamestate.registerEvents()
	state = TitleState()
	gamestate.switch(state)
