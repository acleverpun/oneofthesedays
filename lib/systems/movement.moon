System = require('lib/systems/system')
Direction = require('lib/geo/direction')

class MovementSystem extends System

	update: (dt) =>
		for entity in *@getTargets()
			{ :movable, :position } = entity\getAll()

			if not movable.goal then continue
			goal = movable.goal
			movable.goal = nil

			position.x, position.y, cols, num = entity.scene.world\move(entity, goal.x, goal.y, (other) =>
				if _.isFunction(other.collision) then return 'cross'
				return 'slide'
			)

			for col in *cols
				if col.type == 'cross' and _.isFunction(col.other.collision)
					col.direction = Direction\fromNormal(col.normal)
					col.offset = position - col.other.data
					col.other\collision(entity, col)

	requires: () => { 'movable', 'position' }
