class Middleclass
	@__inherited: (child) =>
		child.name = child.__name

	new: () =>
		@class = @@
