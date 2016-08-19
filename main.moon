require('src/debug')
export _ = require('vendor/lodash/src/lodash')
lovetoys = require('vendor/lovetoys/lovetoys')
lovetoys.initialize()

states = require('vendor/hump/gamestate')
TitleState = require('lib/states/title')

love.load = () ->
	love.graphics.setNewFont(12)
	love.graphics.setBackgroundColor(0 ,0, 0)
	love.graphics.setColor(255, 255, 255)

	states.registerEvents()
	states.switch(TitleState())
