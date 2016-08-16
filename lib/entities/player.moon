Entity = require('lib/entities/entity')
Position = require('lib/components/position')
Drawable = require('lib/components/drawable')

class Player extends Entity
	new: (@x, @y) =>
		super()

		@width = 50
		@height = 50

		@addMultiple({
			Position(@x, @y),
			Drawable(@width, @height, { 255, 100, 100 })
		})
