Caste = require('vendor/caste/lib/caste')
wave = require('vendor/wave/wave')

class Audio extends Caste

	new: (@path, @type = 'stream') =>
		@sound = wave\newSource(@path, @type)

	getSound: () => @sound

	proxy: (method, ...) =>
		-- args = ...
		-- pcall(() -> @sound\play(args))

	play: (...) => @proxy('play', ...)
	stop: (...) => @proxy('stop', ...)
	pause: (...) => @proxy('pause', ...)
	resume: (...) => @proxy('resume', ...)
