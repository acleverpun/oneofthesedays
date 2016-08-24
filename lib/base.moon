class Base
	@__inherited: (child) =>
		child.name = child.__name

	new: () =>
		@class = @@
		@className = @@__name
		@type = _.lowerFirst(@@__name)
