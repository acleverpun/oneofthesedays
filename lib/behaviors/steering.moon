Caste = require('vendor/caste/lib/caste')
{ :Vector } = require('vendor/hug/lib/geo')

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

	direct: (...) => @add(@doDirect(...))
	seek: (target, slowingRadius = 50) => @add(@doSeek(target, slowingRadius))
	flee: (target, fleeRadius = 50) => @add(@doFlee(target, fleeRadius))
	pursue: (target, slowingRadius = 50) => @add(@doPursue(target, slowingRadius))
	evade: (target, fleeRadius = 50) => @add(@doEvade(target, fleeRadius))
	wander: (...) => @add(@doWander(...))

	-- Direct path to target
	doDirect: (target) => target - @host.position

	-- Steers toward target
	doSeek: (target, slowingRadius = 0) =>
		idealVelocity = @doDirect(target)
		distance = #idealVelocity

		factor = @maxSpeed
		if distance < slowingRadius then factor *= distance / slowingRadius

		return with idealVelocity
			\normalize()
			\scale(factor)
			\subtract(@host.velocity)

	-- Steers away from target
	doFlee: (target, fleeRadius = math.huge) =>
		idealVelocity = -@doDirect(target)
		distance = #idealVelocity

		if distance >= fleeRadius then return

		return with idealVelocity
			\normalize()
			\scale(@maxSpeed)
			\subtract(@host.velocity)

	-- Steers toward target's future projection
	doPursue: (target, slowingRadius) =>
		distance = target.position\distanceTo(@host.position)
		updatesNeeded = distance / @maxSpeed
		tv = target.velocity or Vector.ZERO
		tv = tv\clone()\scale(updatesNeeded)
		targetFuturePosition = target.position\clone()\add(tv)
		return @doSeek(targetFuturePosition, slowingRadius)

	-- Steers away from target's future projection
	doEvade: (target, fleeRadius) =>
		distance = target.position\distanceTo(@host.position)
		updatesNeeded = distance / @maxSpeed
		tv = target.velocity or Vector.ZERO
		tv = tv\clone()\scale(updatesNeeded)
		targetFuturePosition = target.position\clone()\add(tv)
		return @doFlee(targetFuturePosition, fleeRadius)

	wanderTheta: love.math.random() * math.tau

	-- Roams the land
	doWander: (radius = 25, distance = 80, thetaLimit = math.tau) =>
		@wanderTheta += love.math.random() * thetaLimit - 0.5 * thetaLimit

		circlePos = with @host.velocity\clone()
			\normalize()
			\multiply(distance)
			\add(@host.position)

		heading = @host.velocity\getHeading()
		angle = @wanderTheta + heading

		circleOffset = Vector(radius * math.cos(angle), radius * math.sin(angle))
		target = circlePos + circleOffset

		return @doSeek(target)
