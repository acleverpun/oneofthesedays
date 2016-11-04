System = require('vendor/secs/lib/system')
Direction = require('lib/geo/direction')

class MovementSystem extends System

	@criteria: System.Criteria({ 'velocity', 'position', 'shape' })

	new: (@map) =>
		@mapWidth = @map.tiled.width * @map.tiled.tilewidth
		@mapHeight = @map.tiled.height * @map.tiled.tileheight

	update: (dt) =>
		for entity in *@entities
			{ :velocity, :position, :shape } = entity\get()

			-- Set heading
			heading = Direction\getHeadingName(velocity)
			if heading != 'NONE' then entity\set('heading', heading)

			-- Calculate new desired position
			position\add(velocity)

			-- Restrict position to map
			position.x = math.min(math.max(position.x, 0), @mapWidth - shape.width)
			position.y = math.min(math.max(position.y, 0), @mapHeight - shape.height)

			-- Attempt to move entity
			position.x, position.y, collisions, num = @map.world\move(entity, position.x, position.y, (other) =>
				if _.isFunction(other.collision) then return 'cross'
				return 'slide'
			)

			-- Set collisions encountered
			entity\set('collisions', collisions)

			-- Handle collisions
			-- TODO: breakout.exe
			for col in *collisions
				if col.type == 'cross' and _.isFunction(col.other.collision)
					col.direction = Direction(col.normal)
					col.offset = position - col.other.position
					col.other\collision(entity, col)
