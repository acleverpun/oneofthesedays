Caste = require('vendor/caste/lib/caste')

class Controls extends Caste

	new: (@list) =>
		for name, control in pairs(@list)
			@[name] = control
