Scene = require('lib/scenes/scene')
Map = require('lib/geo/map')
PauseScene = require('lib/scenes/pause')
entities = require('lib/entities')
RenderSystem = require('lib/systems/render')
InputSystem = require('lib/systems/input')
PlayerInputSystem = require('lib/systems/player-input')
MovementSystem = require('lib/systems/movement')
BehaviorsSystem = require('lib/systems/behaviors')
CommandSystem = require('lib/systems/command')
Vector = require('lib/geo/vector')
Direction = require('lib/geo/direction')

class AreaScene extends Scene

	new: (mapId) =>
		super()

		@map = Map(mapId)
		@scale = 1

		-- Hide hidden layers without being hidden in the editor
		for layer in *@map\getTiledLayers()
			if layer.properties.hidden then layer.visible = false

		@entityLayerName = 'entities'
		with @map
			\addLayer(@entityLayerName, 'actors')
			\addSystem(RenderSystem(), @entityLayerName)
			\addSystem(InputSystem(), @entityLayerName)
			\addSystem(PlayerInputSystem(@map), @entityLayerName)
			\addSystem(BehaviorsSystem(), @entityLayerName)
			\addSystem(CommandSystem(), @entityLayerName)
			\addSystem(MovementSystem(@map), @entityLayerName)

	enter: (previous, @transition) =>
		super(previous)

		if @transition.player
			@player = @transition.player\clone(@)
		playerExists = not not @transition.player
		fromWarp = @transition.fromWarp

		boundaries = {}
		doors = {}
		for object in *@map\getTiledObjects()
			if not object then continue
			if object.type == 'Player' and @player then continue
			if object.type == 'zones/Boundary' then _.push(boundaries, object)
			if object.type == 'zones/Door' then _.push(doors, object)

			-- Set player if not passed in transition
			entity = entities[object.type](@, object)
			if object.type == 'Player'
				@player = entity
				continue
			@map\addEntity(entity, @entityLayerName)

		unless @player then error 'No player found.'

		if fromWarp
			warp = nil

			if fromWarp\is('Boundary')
				-- Determine which boundary to spawn at
				for boundary in *boundaries
					-- Map boundaries to directions
					if boundary.width > boundary.height
						if not boundaries.NORTH or boundary.y < boundaries.NORTH.y
							boundaries.NORTH = boundary
						if not boundaries.SOUTH or boundary.y > boundaries.SOUTH.y
							boundaries.SOUTH = boundary
					else
						if not boundaries.WEST or boundary.x < boundaries.WEST.x
							boundaries.WEST = boundary
						if not boundaries.EAST or boundary.x > boundaries.EAST.x
							boundaries.EAST = boundary
				heading = Direction\getHeadingName(@transition.direction)
				warp = boundaries[heading]
			elseif fromWarp\is('Door')
				-- Determine which door to spawn at
				warp = doors[1]
				if playerExists and not @transition.toWarp and @transition.fromScene.transition
					originalDoor = @transition.fromScene.transition.fromWarp
					if originalDoor then @transition.toWarp = originalDoor.tile.id
				if @transition.toWarp
					warp = _.find(doors, (door) -> _.includes({ door.name, door.id }, @transition.toWarp))
					if not warp then warp = doors[1]

			if playerExists
				@player.position.x = warp.x
				@player.position.y = warp.y

			-- Handle specific spawn points
			if toPosition = @transition.toPosition
				if toPosition.x then @player.position.x = toPosition.x
				if toPosition.y then @player.position.y = toPosition.y
			-- Handle door offsets
			if @transition.offset and @transition.fromWarp
				doorScaleWidth = warp.width / @transition.fromWarp.shape.width
				doorScaleHeight = warp.height / @transition.fromWarp.shape.height
				if @transition.offset.x then @player.position.x += @transition.offset.x * doorScaleWidth
				if @transition.offset.y then @player.position.y += @transition.offset.y * doorScaleHeight
			-- Handle direction
			if @transition.direction
				if @transition.direction == Direction.NORTH then @player.position.y += warp.height
				if @transition.direction == Direction.SOUTH then @player.position.y -= warp.height
				if @transition.direction == Direction.WEST then @player.position.x += warp.width
				if @transition.direction == Direction.EAST then @player.position.x -= warp.width

		@map\addEntity(@player, @entityLayerName)

	update: (dt) =>
		super(dt)
		@map\update(dt)
		@windowWidth = love.graphics.getWidth()
		@windowHeight = love.graphics.getHeight()
		tx = math.floor(@player.position.x - @windowWidth / @scale / 2)
		ty = math.floor(@player.position.y - @windowHeight / @scale / 2)
		@translation = Vector(tx, ty)

	draw: () =>
		love.graphics.push()

		love.graphics.scale(@scale)
		love.graphics.translate(-@translation.x, -@translation.y)

		@map\setDrawRange(@translation.x, @translation.y, @windowWidth, @windowHeight)
		@map\draw()

		if @DEBUG then @map\drawCollisions()

		love.graphics.pop()

		super()

	keypressed: (key) =>
		super(key)
		if key == 'escape' then @push(PauseScene())

	mousepressed: (x, y, button) =>
		if @DEBUG and button == 2
			eventPosition = Vector(x, y)
			-- TODO: Make work not just for player
			position = eventPosition + @translation - Vector(200, 150)

			items, len = @map\queryPoint(position)
			if len > 0 then dump items
