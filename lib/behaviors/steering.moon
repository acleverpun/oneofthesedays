Caste = require('vendor/caste/lib/caste')
Vector = require('lib/geo/vector')

class Steering extends Caste

	new: (@host) =>
		@steering = Vector.ZERO
		if not @host.velocity then @host\set('velocity', Vector.ZERO)

	reset: () =>
		@steering\reset()
		return @

	add: (vector) =>
		@steering\add(vector)
		return @

	init: (dt) =>
		@maxSpeed = @host.maxSpeed * dt
		return @

	update: (dt) =>
		{ :position, :velocity, :mass, :maxForce } = @host\get()
		@steering\truncate(maxForce)
		@steering\scale(1 / mass)
		velocity\add(@steering)
		velocity\truncate(@maxSpeed)
		return @

	direct: (...) => @add(@doDirect(...))
	seek: (target, slowingRadius = 100) => @add(@doSeek(target, slowingRadius))
	flee: (...) => @add(@doFlee(...))
	wander: (...) => @add(@doWander(...))
	evade: (...) => @add(@doEvade(...))
	pursuit: (...) => @add(@doPursuit(...))

	doDirect: (target) =>
		{ :position } = @host\get()
		return target - position

	doSeek: (target, slowingRadius = 0) =>
		{ :position, :velocity } = @host\get()
		desiredVelocity = target - position
		distance = desiredVelocity\getLength()
		desiredVelocity\normalize()

		if distance < slowingRadius
			desiredVelocity\scale(@maxSpeed * distance / slowingRadius)
		else
			desiredVelocity\scale(@maxSpeed)

		return desiredVelocity\subtract(velocity)

	doFlee: (target) =>

	doWander: () =>

	doEvade: (target) =>

	doPursuit: (target) =>
