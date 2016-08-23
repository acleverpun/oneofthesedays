class Transition
	new: (@fromState, @toState, data = {}) =>
		@player = data.player or @fromState.player
		@fromDoor = data.fromDoor
		@toDoor = data.toDoor
		@toPoint = data.toPoint
