Caste = require('vendor/caste/lib/caste')
Vector = require('lib/geo/vector')

class Steering extends Caste

	new: (@host) =>
		@reset()
		if not @host.velocity then @host\set('velocity', Vector.ZERO)

	direct: (...) => @steering\add(@doSeek(...))
	seek: (target, slowingRadius = 100) => @steering\add(@doSeek(target, slowingRadius))
	flee: (...) => @steering\add(@doFlee(...))
	wander: (...) => @steering\add(@doWander(...))
	evade: (...) => @steering\add(@doEvade(...))
	pursuit: (...) => @steering\add(@doPursuit(...))

	reset: () => @steering = Vector.ZERO\clone()

	update: (dt) =>
		{ :position, :velocity, :mass, :maxSpeed, :maxForce } = @host\get()
		if not velocity then velocity = Vector.ZERO
		@steering\truncate(maxForce)
		@steering\scale(1 / mass)
		velocity\add(@steering)
		velocity\truncate(maxSpeed * dt)
		@host\set('velocity', velocity)

	doDirect: (target) =>
		{ :position } = @host\get()
		return target - position

	doSeek: (target, slowingRadius = 0) =>
		{ :position, :velocity, :maxSpeed } = @host\get()
		desiredVelocity = target - position
		distance = desiredVelocity\getLength()
		desiredVelocity\normalize()

		if distance < slowingRadius
			desiredVelocity\scale(maxSpeed * distance / slowingRadius)
		else
			desiredVelocity\scale(maxSpeed)

		return desiredVelocity\subtract(velocity)

	doFlee: (target) =>

	doWander: () =>

	doEvade: (target) =>

	doPursuit: (target) =>

	run: () => Vector.ZERO
