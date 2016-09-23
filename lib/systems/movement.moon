System = require('vendor/secs/lib/system')
Direction = require('lib/geo/direction')

class MovementSystem extends System

	@criteria: System.Criteria({ 'goal', 'position', 'shape' })

	new: (map) =>
		@mapWidth = map.width * map.tilewidth
		@mapHeight = map.height * map.tileheight

	update: (dt) =>
		for entity in *@entities
			{ :goal, :position, :shape } = entity\get()

			goal.x = math.max(goal.x, 0)
			goal.y = math.max(goal.y, 0)
			goal.x = math.min(goal.x, @mapWidth - shape.width)
			goal.y = math.min(goal.y, @mapHeight - shape.height)

			-- TODO: don't create a direction every frame
			entity\set('direction', Direction(goal - position))

			position.x, position.y, collisions, num = entity.scene.world\move(entity, goal.x, goal.y, (other) =>
				if _.isFunction(other.collision) then return 'cross'
				return 'slide'
			)

			entity\set('collisions', collisions)
			entity\remove('goal')

			for col in *collisions
				if col.type == 'cross' and _.isFunction(col.other.collision)
					col.direction = Direction(col.normal)
					col.offset = position - col.other.data
					col.other\collision(entity, col)
