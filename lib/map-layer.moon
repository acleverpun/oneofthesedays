Engine = require('lib/engine')

class MapLayer
	new: (@map, @name, index) =>
		exists = false

		-- Support using an existing layer
		for l, layer in ipairs @map.layers
			if layer.name == @name
				exists = true
				index = l

		-- Default to adding to the top
		if not _.isNumber(index) then index = #@map.layers + 1

		-- Create STI layer, and store properties here
		layer = nil
		if exists then
			layer = @map\convertToCustomLayer(index)
			@name = layer.name
		else
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
