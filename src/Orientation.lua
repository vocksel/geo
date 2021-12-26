--[=[
	An enum value used to represent a shape's orientation.

	@interface Orientation
	@within Geo
	@tag enum

	.North "North"
	.NorthEast "NorthEast"
	.East "East"
	.SouthEast "SouthEast"
	.South "South"
	.SouthWest "SouthWest"
	.West "West"
	.NorthWest "NorthWest"
]=]

--[=[
	@prop Orientation Orientation

	A table containing all members of the `Orientation` enum, e.g., `Geo.Orientation.North`.

	@within Geo
	@readonly
	@tag enums
]=]

local Orientation = {
	North = "North",
	NorthEast = "NorthEast",
	East = "East",
	SouthEast = "SouthEast",
	South = "South",
	SouthWest = "SouthWest",
	West = "West",
	NorthWest = "NorthWest",
}

return Orientation
