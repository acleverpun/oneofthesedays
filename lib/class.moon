class Class
	@name: 'Class'
	@type: 'class'
	@parents: { @ }
	@isClass: true

	@__inherited: (child) =>
		child.name = child.__name
		child.parents = _.union(@@parents, { @@ })

	new: () =>
		@class = @@
		@className = @@name
		@type = _.lowerFirst(@@name)
		@isInstance = true

	is: (type) =>
		if type == @ then return true

		if _.isString(type)
			if _.lowerFirst(type) == type
				return 'lower'
			else
				return 'upper'
		if type.isClass
			if type == @@ then return true
			return _.some(@@parents, (Parent) -> return type == Parent)
		if type.isInstance
			-- if type == @ then return true
			-- return _.some(@@parents, (Parent) -> return type == Parent)
			return 'instance'
