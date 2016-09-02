Entity = require('lib/entities/entity')
Sprite = require('lib/display/sprite')
Vector = require('lib/geo/vector')
Shape = require('lib/geo/shape')

class Npc extends Entity

	new: (...) =>
		super(...)

		@addMultiple({
			Sprite('ff4-characters.png', Vector(64, 119), Shape(16, 16))
		})
