Caste = require('vendor/caste/lib/caste')
baton = require('vendor/baton/baton')

class Input extends Caste

	new: (@spec) =>
		@input = baton.new(@spec, love.joystick.getJoysticks()[1])

	get: (...) => @input\get(...)
	down: (...) => @input\down(...)
	pressed: (...) => @input\pressed(...)
	released: (...) => @input\released(...)
	changeSpec: (...) => @input\changeControls(...)
	getActiveDevice: (...) => @input\getActiveDevice(...)
	update: (...) => @input\update(...)
