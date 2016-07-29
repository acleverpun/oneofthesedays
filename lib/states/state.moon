class State
	keypressed: (key) =>
		if key == 'escape' then love.event.push('quit')
