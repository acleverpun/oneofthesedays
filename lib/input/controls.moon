Class = require('lib/class')

class Controls extends Class

	new: (@list) =>
		for name, control in pairs(@list)
			@[name] = control
