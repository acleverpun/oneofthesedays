Entity = require('lib/entities/entity')
Sprite = require('lib/display/sprite')
Vector = require('lib/geo/vector')
Shape = require('lib/geo/shape')

class Npc extends Entity

	new: (...) =>
		super(...)

		@addMultiple({
			target: @scene.player,
			maxSpeed: 50,
			Sprite('ff4-characters.png', Vector(64, 119), Shape(16, 16))
		})
