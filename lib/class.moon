init = () =>
	@class = @@
	@type = _.lowerFirst(@@name)

class Class

	@name: 'Class'
	@type: 'class'
	@parents: { @ }
	@isClass: true

	isInstance: true

	@__inherited: (child) =>
		child.name = child.__name
		child.type = _.lowerFirst(child.name)
		child.parents = _.union(@@parents, { @@ })

		-- Call setup code in constructor, so children do not need to call `super`
		constructor = child.__init
		child.__init = (...) =>
			init(@)
			constructor(@, ...)

	-- new: () => init(@)

	is: (type) =>
		if type == @ then return true
		if type == @@ then return true
		if type == @type then return true
		if type == @@name then return true

		if _.isString(type)
			return _.some(@@parents, (Parent) -> _.includes({ Parent.type, Parent.name }, type))
		if _.isInstance(type)
			return _.some(@@parents, (Parent) -> type.class == Parent)
		if _.isClass(type)
			return _.some(@@parents, (Parent) -> type == Parent)

		return false
