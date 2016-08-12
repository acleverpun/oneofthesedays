State = require('lib/states/state')
PauseState = require('lib/states/pause')
Entity = require('lib/entities/entity')
Player = require('lib/entities/player')

class GameState extends State
	init: () =>
		entity = Entity()
		entity\foo()

		-- player = Player()
		-- player\foo()

	draw: () =>
		love.graphics.print('hi', 200, 100)

	keypressed: (key) =>
		super(key)
		if key == 'escape' then @gamestate.push(PauseState())
