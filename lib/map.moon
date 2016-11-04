Caste = require('vendor/caste/lib/caste')
STI = require('vendor/sti/sti')
bump = require('vendor/bump/bump')

class Map extends Caste

	new: (@id) =>
		@tiled = STI("assets/maps/#{@id}", { 'bump' })
		@world = bump.newWorld(@tiled.tilewidth)
		@tiled\bump_init(@world)
