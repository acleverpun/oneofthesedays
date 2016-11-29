Caste = require('vendor/caste/lib/caste')
wave = require('vendor/wave/wave')
moon = require('moon')

class Audio extends Caste

	new: (@path, @type = 'stream') =>
		@sound = wave\newSource(@path, @type)

		moon.mixin_object(@, @sound, {
			'play',
			'stop',
			'pause',
			'resume',
			'setLooping'
		})

		-- TEMP
		@play = () =>
