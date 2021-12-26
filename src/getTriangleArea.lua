--[=[
	@function getTriangleArea

	Calculates the are of a triangle from any three points.

	```lua
	local area = getTriangleArea(
		Vector2.new(x1, y1),
		Vector2.new(x2, y2),
		Vector2.new(x3, y3)
	)
	```

	:::info
	This function uses the Heron's Formula to calculate the area of a triangle from any three
	points
	:::

	@within Geo
	@tag helper
	@param p1 Vector2
	@param p2 Vector2
	@param p3 Vector3
	@return number -- The area of the given triangle
]=]

local t = require(script.Parent.t)

local check = t.tuple(t.Vector2, t.Vector2, t.Vector2)

local function getTriangleArea(p1: Vector2, p2: Vector2, p3: Vector2)
	assert(check(p1, p2, p3))

	local a = (p1 - p2).Magnitude
	local b = (p2 - p3).Magnitude
	local c = (p3 - p1).Magnitude
	local s = (a + b + c) / 2

	return math.sqrt(s * (s - a) * (s - b) * (s - c))
end

return getTriangleArea
