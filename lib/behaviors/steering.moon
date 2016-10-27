Caste = require('vendor/caste/lib/caste')
Vector = require('lib/geo/vector')

class Steering extends Caste

	new: (@host) =>
		@steering = Vector.ZERO\clone()
		if not @host.velocity then @host\set('velocity', Vector.ZERO\clone())

	reset: () =>
		@steering\reset()
		return @

	add: (vector) =>
		if vector then @steering\add(vector)
		return @

	init: (dt) =>
		@maxSpeed = @host.maxSpeed * dt
		return @

	update: (dt) =>
		{ :position, :velocity, :mass, :maxForce } = @host\get()
		@steering\truncate(maxForce)
		-- @steering\scale(1 / mass)
		velocity\add(@steering)
		velocity\truncate(@maxSpeed)
		return @

	direct: (...) => @add(@doDirect(...))
	seek: (target, slowingRadius = 50) => @add(@doSeek(target, slowingRadius))
	flee: (target, fleeRadius = 50) => @add(@doFlee(target, fleeRadius))
	wander: (...) => @add(@doWander(...))
	evade: (...) => @add(@doEvade(...))
	pursuit: (...) => @add(@doPursuit(...))

	doDirect: (target) => target - @host.position

	doSeek: (target, slowingRadius = 0) =>
		idealVelocity = @doDirect(target)
		distance = idealVelocity\getLength()

		factor = @maxSpeed
		if distance < slowingRadius then factor *= distance / slowingRadius

		return with idealVelocity
			\normalize()
			\scale(factor)
			\subtract(@host.velocity)

	doFlee: (target, fleeRadius = 0) =>
		idealVelocity = -@doDirect(target)
		distance = idealVelocity\getLength()

		if distance >= fleeRadius then return

		return with idealVelocity
			\normalize()
			\scale(@maxSpeed)
			\subtract(@host.velocity)

	doWander: () =>

	doEvade: (target) =>

	doPursuit: (target) =>
