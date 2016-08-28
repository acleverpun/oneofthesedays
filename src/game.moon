require('src/debug')
export _ = require('lib/utils/lodash')
lovetoys = require('vendor/lovetoys/lovetoys')
lovetoys.initialize()

scenes = require('vendor/hump/gamestate')
TitleScene = require('lib/scenes/title')

love.load = () ->
	love.graphics.setNewFont(12)
	love.graphics.setBackgroundColor(0 ,0, 0)
	love.graphics.setColor(255, 255, 255)

	scenes.registerEvents()
	scenes.switch(TitleScene())
