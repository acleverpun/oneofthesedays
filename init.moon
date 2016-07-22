love.load = () ->
	love.graphics.setNewFont(12)
	love.graphics.setBackgroundColor(0 ,0, 0)
	love.graphics.setColor(255, 255, 255)

love.draw = () ->
	love.graphics.print('aoeu', 400, 200)

love.keypressed = (key) ->
	if key == 'q' then love.event.push('quit')
