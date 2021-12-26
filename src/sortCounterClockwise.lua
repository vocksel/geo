local t = require(script.Parent.t)

local getPolarAngleCheck = t.tuple(t.Vector2, t.Vector2)

local function getPolarAngle(p1, p2)
	assert(getPolarAngleCheck(p1, p2))

	return math.atan2(p1.y - p2.y, p1.x - p2.x)
end

local sortCounterClockwiseCheck = t.array(t.Vector2)

--[=[
	@function sortCounterClockwise

	Sorts an array of points in counterclockwise order, returning the newly
	sorted array.

	```lua
	local points = { Vector2.new(x1, y1), Vector2.new(x2, y2), Vector2.new(x3, y3), ... }
	local sorted = sortCounterClockwise(points)
	```

	This function is crucial for `getConvexHull()` which relies on
	counterclockwise order for calculating the hull.

	:::note
	The bottommost point is selected as an anchor and every other point is
	sorted by its angle relative to the anchor. The anchor is therefore the
	first point in the resulting list, and every consecutive point has a
	counterclockwise angle to the anchor that is bigger than the last.
	:::

	@within Geo
	@tag helper
	@param points { Vector2 }
	@return { Vector2 } -- Returns a new array where each Vector2 in `points` is
		sorted in counterclockwise order.
]=]
local function sortCounterClockwise(points)
	assert(sortCounterClockwiseCheck(points))

	local copy = {}
	for _, point in ipairs(points) do
		table.insert(copy, point)
	end
	-- Now we can mutate the array without worrying about the input table :)
	points = copy

	local anchor = points[1]

	-- Search for the bottommost point in the list. If there is a tie between
	-- two points on the y axis, we use the rightmost point.
	--
	-- Remember that in Roblox's coordinate system a greater Y value is farther
	-- down the screen than a lower Y value.
	for _, point in ipairs(points) do
		if point.y > anchor.y or point.y == anchor.y and point.x > anchor.x then
			anchor = point
		end
	end

	-- Sort each point by the angle made between it and the anchor point.
	-- Smaller angles come first.
	table.sort(points, function(a, b)
		return getPolarAngle(a, anchor) > getPolarAngle(b, anchor)
	end)

	return points
end

return sortCounterClockwise
