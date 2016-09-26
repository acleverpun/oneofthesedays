System = require('vendor/secs/lib/system')
Direction = require('lib/geo/direction')

class MovementSystem extends System

	@criteria: System.Criteria({ 'velocity', 'position', 'shape' })

	new: (@world, map) =>
		@mapWidth = map.width * map.tilewidth
		@mapHeight = map.height * map.tileheight

	update: (dt) =>
		for entity in *@entities
			{ :velocity, :position, :shape } = entity\get()

			-- Set heading
			heading = Direction\getHeading(velocity)
			if heading != 'NONE' then entity\set('heading', heading)

			-- Determine course
			-- TODO: don't create a vector every frame, but call `position\add`
			course = position + velocity
			course.x = math.min(math.max(course.x, 0), @mapWidth - shape.width)
			course.y = math.min(math.max(course.y, 0), @mapHeight - shape.height)

			-- Attempt to move entity
			position.x, position.y, collisions, num = @world\move(entity, course.x, course.y, (other) =>
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
					col.offset = position - col.other.data
					col.other\collision(entity, col)
