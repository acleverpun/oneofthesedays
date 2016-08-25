class Class
	@name: 'Class'
	@parents: { @ }

	@__inherited: (child) =>
		child.name = child.__name
		child.parents = _.union(@@parents, { @@ })

	new: () =>
		@class = @@
		@className = @@name
		@type = _.lowerFirst(@@name)

		@isClass = true
