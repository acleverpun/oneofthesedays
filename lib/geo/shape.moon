Caste = require('vendor/caste/lib/caste')

class Shape extends Caste

	new: (width, height) =>
		if _.isTable(width)
				-- @param {Table{/(width|height)/ => Number}}
			@width = width.width
			@height = width.height
		else
			-- @param {Number}
			-- @param {Number}
			@width = width
			@height = height
