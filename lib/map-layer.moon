Engine = require('lib/engine')

class MapLayer
	new: (@map, @name, index) =>
		if not _.isNumber(index) then index = #@map.layers + 1

		-- Create STI layer, and store properties here
		layer = @map\addCustomLayer(@name, index)
		@type = layer.type
		@visible = layer.visible
		@opacity = layer.opacity
		@properties = layer.properties

		-- Replace original layer with this instance
		@map.layers[index] = @
		@map.layers[@name] = @

		@engine = Engine()

	update: (dt) =>
		@engine\update(dt)

	draw: () =>
		@engine\draw()
