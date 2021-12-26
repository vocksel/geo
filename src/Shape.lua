--[=[
	@interface Shape

	An enum value used to represent a shape from a series of points.

	.Line "Line"
	.Circle "Circle"
	.Square "Square"
	.Rectangle "Rectangle"
	.Triangle "Triangle"
	.Chevron "Chevron"

	@within Geo
	@tag enum
]=]

--[=[
	@prop Shape Shape

	A table containing all members of the `Shape` enum, e.g., `Geo.Shape.Rectangle`.

	@within Geo
	@readonly
	@tag enums
]=]

local Shape = {
	Line = "Line",
	Circle = "Circle",
	Square = "Square",
	Rectangle = "Rectangle",
	Triangle = "Triangle",
	Chevron = "Chevron",
}

return Shape
