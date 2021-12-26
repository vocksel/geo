local t = require(script.Parent.t)
local getTriangleArea = require(script.Parent.getTriangleArea)

local check = t.array(t.Vector2)

--[=[
	@function getLargestTriangle

	Given an ordered list of Vector2s, this function will calculate the 3 points
	that make up the maximum-area triangle incribed within the full list.

	![Maximum-area triangle inscribed within a convex hull](/largest-triangle.png)

	:::info
	This uses a mix of Algorithm 2 described in the paper "Maximum-Area Triangle
	in a Convex Polygon, Revisited" as well as the sample code in this
	[StackOverflow post](https://stackoverflow.com/a/1621913)
	:::

	@within Geo
	@tag helper
	@param points { Vector2 } -- Array of points to get the largest triangle of
	@return { Vector2 } -- Returns an array of the 3 points that compose the maximum-area triangle.
]=]
local function getLargestTriangle(points: { Vector2 })
	assert(check(points))

	if #points <= 3 then
		return points
	end

	-- FIXME: Rewrite this so the code to step to the next point does not have to
	-- loop through the array O(n) times.
	local function step(point)
		for i, other in ipairs(points) do
			if point == other then
				return points[i + 1] or points[1]
			end
		end
	end

	local a = points[1]
	local b = step(a)
	local c = step(b)
	local triangle = { a, b, c }

	-- The algorithm works as follows:
	-- 1. Advance c so long as the area increases. Else:
	-- 2. Advance b. If that increases the area, repeat (1). Else:
	-- 3. Advance a. If a returns to the first point in the array, return the
	--    points we have accumulated. Else:
	-- 4. Shift the points forward and return to (1).

	while true do
		-- Advance c so long as the area increases. After the area stops
		-- increasing, do the same by advancing b so long as the area increases.
		-- After the area stops increasing for b, stop the loop.
		while true do
			while getTriangleArea(a, b, step(c)) > getTriangleArea(a, b, c) do
				c = step(c)
			end

			if getTriangleArea(a, step(b), c) > getTriangleArea(a, b, c) then
				b = step(b)
			else
				break
			end
		end

		-- Update the current best triangle.
		if getTriangleArea(a, b, c) > getTriangleArea(unpack(triangle)) then
			triangle = { a, b, c }
		end

		local nextA = step(a)
		if nextA == points[1] then
			return triangle
		end

		-- Step forward to do it all again :)
		a = nextA
		b = step(a)
		c = step(b)
	end
end

return getLargestTriangle
