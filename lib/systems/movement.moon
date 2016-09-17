System = require('lib/secs/system')
Direction = require('lib/geo/direction')
Vector = require('lib/geo/vector')

class MovementSystem extends System

	@criteria: System.Criteria({ 'movable', 'position', 'shape' })

	new: (map) =>
		super()
		@mapWidth = map.width * map.tilewidth
		@mapHeight = map.height * map.tileheight

	update: (dt) =>
		for entity in *@entities
			{ :movable, :position, :shape } = entity\get()

			if not movable.goal then continue
			goal = movable.goal
			movable.goal = nil

			goal.x = math.max(goal.x, 0)
			goal.y = math.max(goal.y, 0)
			goal.x = math.min(goal.x, @mapWidth - shape.width)
			goal.y = math.min(goal.y, @mapHeight - shape.height)

			entity.direction = Direction\fromVector(Vector(goal - position))

			position.x, position.y, movable.collisions, num = entity.scene.world\move(entity, goal.x, goal.y, (other) =>
				if _.isFunction(other.collision) then return 'cross'
				return 'slide'
			)

			for col in *movable.collisions
				if col.type == 'cross' and _.isFunction(col.other.collision)
					col.direction = Direction\fromVector(col.normal)
					col.offset = position - col.other.data
					col.other\collision(entity, col)

	onAdd: (entity) =>
		entity.direction = Direction.NONE
