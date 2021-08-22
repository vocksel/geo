--[[
	Gets an approximation of the number of corners a shape has.

	Keep in mind that this approximation is fairly rough, but it gives a good
	idea of how many sharp turns a shape has.

	Usage:

	    local points = { Vector2.new(), Vector2.new(), ... }
	    getCornerIndices(points)

	    -- Optionally increase the size of the max angle to be more forgiving about
	    -- when a corner is detected.
	    getCornerIndices(points, 140)

	Params:

	points: Array<Vector2>

	    List of points that compose a shape. This should be sorted in some way.
	    Using sortCounterClockwise should be plenty.

	maxAngle: int = 100

	    Controls the maximum angle for a corner to exist. The bigger this value,
	    the less strict a corner is. Default: 100.

	minAngle: int = 10

	    Controls how big an angle has to be to still be counted as a corner.
	    This value is primarily used to prevent the end of a line  from being
	    counted as corners.

	Returns an array of the indices where a corner exists in the points array.
	The reason the indices are returned rather than the Vector2 itself is so its
	easy to traverse relative to the corners. For example, if you have a corner
	at index 10, then you can consider the points from 1-9 to be a line.
]]

local t = require(script.Parent.t)

local cycleCheck = t.tuple(t.array(t.any), t.numberPositive)

-- Loops back to the start of the array if the index exceeds the array length.
-- This is used so we can check if the first point to see if it is a corner.
local function cycle(array: table, index: number)
	assert(cycleCheck(array, index))

	return array[index] or array[index - #array]
end

local getCornerIndicesCheck = t.tuple(t.array(t.Vector2), t.numberPositive, t.numberPositive)

local function getCornerIndices(points: { Vector2 }, maxAngle: number, minAngle: number)
	assert(getCornerIndicesCheck(points, maxAngle, minAngle))

	-- Defaults to an arbitrary number that "feels" right for when a corner
	-- should occur. Fully customizeable.
	maxAngle = maxAngle or 100

	-- The minimum angle prevents lines from being detected as having corners.
	-- Since we loop #points + 2 times, this means when we have a line there is
	-- technically a very sharp corner from the last two points to the first. As
	-- such, if an angle is too small we don't count it as a corner to avoid
	-- this edge  case.
	minAngle = minAngle or 10

	local indices = {}

	if #points < 3 then
		return indices
	end

	for i = 1, #points do
		local cornerIndex = i + 1

		local first: Vector2 = cycle(points, i)
		local maybeCorner: Vector2 = cycle(points, cornerIndex)
		local last: Vector2 = cycle(points, i + 2)

		-- Need to create some vectors that are relative to the first point. If
		-- these were relative to the origin we would have issues.
		local v1 = (first - maybeCorner)
		local v2 = (first - last)

		-- This is the distance from 'first' that aligns perpendicularly with
		-- maybeCorner. We can then use this to find the Vector2 that is
		-- perpendicular.
		local projection = v1:Dot(v2) / v2.Magnitude

		-- This is the projected point between the 'first' and 'last' point that is
		-- perpendicular with maybeCorner. We now have two right triangles on
		-- either side of this point to work with!
		local point = first:Lerp(last, projection / v2.Magnitude)

		-- Trig time! We just need to calculate the sum of angles we're home
		-- free! The first angle is super simple, since the opposite side from
		-- maybeCorner is the projection, and the hypotenuse is the magnitude of
		-- v1. The second angle is harder to figure out because it is on the
		-- other side of the projection scaler. We have to start from the last
		-- vector and go towards the first vector and maybeCorner, but its
		-- essentially the same math.
		local a1 = math.asin(projection / v1.Magnitude)
		local a2 = math.asin((last - point).Magnitude / (last - maybeCorner).Magnitude)
		local angle = math.deg(a1 + a2)

		if minAngle <= angle and angle <= maxAngle then
			if cornerIndex > #points then
				cornerIndex -= #points
			end

			-- print(("\t(%s) %.2f degrees"):format(tostring(maybeCorner), angle))
			table.insert(indices, cornerIndex)
		end
	end

	return indices
end

return getCornerIndices
