Class = require('lib/class')
Secs = require('lib/secs/secs')

class MapLayer extends Class

	new: (@map, @name, index) =>
		exists = false

		-- Support using an existing layer
		for l, layer in ipairs @map.layers
			if _.isString(@name) and layer.name == @name
				exists = true
				index = l
			if _.isString(index) and layer.name == index
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

		@secs = Secs()

	update: (dt) =>
		@secs\update(dt)

	draw: () =>
		@secs\draw()
