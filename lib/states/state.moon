class State
	keypressed: (key) =>
		if key == 'escape' then love.event.push('quit')
		if key == 'q' then love.event.push('quit')
