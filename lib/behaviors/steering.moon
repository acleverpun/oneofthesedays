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
	pursue: (target, slowingRadius = 50) => @add(@doPursue(target, slowingRadius))
	evade: (target, fleeRadius = 50) => @add(@doEvade(target, fleeRadius))
	wander: (...) => @add(@doWander(...))

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

	doFlee: (target, fleeRadius = math.huge) =>
		idealVelocity = -@doDirect(target)
		distance = idealVelocity\getLength()

		if distance >= fleeRadius then return

		return with idealVelocity
			\normalize()
			\scale(@maxSpeed)
			\subtract(@host.velocity)

	doPursue: (target, slowingRadius) =>
		distance = target.position\distanceTo(@host.position)
		updatesNeeded = distance / @maxSpeed
		tv = target.velocity or Vector.ZERO
		tv = tv\clone()\scale(updatesNeeded)
		targetFuturePosition = target.position\clone()\add(tv)
		return @doSeek(targetFuturePosition, slowingRadius)

	doEvade: (target, fleeRadius) =>
		distance = target.position\distanceTo(@host.position)
		updatesNeeded = distance / @maxSpeed
		tv = target.velocity or Vector.ZERO
		tv = tv\clone()\scale(updatesNeeded)
		targetFuturePosition = target.position\clone()\add(tv)
		return @doFlee(targetFuturePosition, fleeRadius)

	doWander: () =>
