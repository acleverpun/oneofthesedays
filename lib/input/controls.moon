Class = require('lib/class')

class Controls extends Class
	new: (@list) =>
		super()
		for name, control in pairs(@list)
			@[name] = control
