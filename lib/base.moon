class Base
	@__inherited: (child) =>
		child.name = child.__name

	new: () =>
		@class = @@
		@type = _.lowerFirst(@@__name)
