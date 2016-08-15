System = require('lib/systems/system')

class DebugSystem extends System
	update: () =>
		@fps = love.timer.getFPS()

	draw: () =>
		love.graphics.print({ { 255, 0, 100 }, 'FPS: ', { 255, 255, 100 }, @fps }, 10, 10)
