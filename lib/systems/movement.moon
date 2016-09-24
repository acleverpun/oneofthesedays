System = require('vendor/secs/lib/system')
Direction = require('lib/geo/direction')

class MovementSystem extends System

	@criteria: System.Criteria({ 'velocity', 'position', 'shape' })

	new: (map) =>
		@mapWidth = map.width * map.tilewidth
		@mapHeight = map.height * map.tileheight

	update: (dt) =>
		for entity in *@entities
			{ :velocity, :position, :shape } = entity\get()

			-- TODO: don't create a vector every frame, but call `position\add`
			goal = velocity + position
			goal.x = math.min(math.max(goal.x, 0), @mapWidth - shape.width)
			goal.y = math.min(math.max(goal.y, 0), @mapHeight - shape.height)

			position.x, position.y, collisions, num = entity.scene.world\move(entity, goal.x, goal.y, (other) =>
				if _.isFunction(other.collision) then return 'cross'
				return 'slide'
			)

			entity\set('collisions', collisions)

			for col in *collisions
				if col.type == 'cross' and _.isFunction(col.other.collision)
					col.direction = Direction(col.normal)
					col.offset = position - col.other.data
					col.other\collision(entity, col)
