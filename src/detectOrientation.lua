--[=[
	@function detectOrientation

	Given a list of points, this function determines which orientation the shape
	is facing.

	```lua
	local points = { Vector2.new(x1, y1), Vector2.new(x2, y2), Vector2.new(x3, y3), ... }

	local orientation = detectOrientation(points)

	if orientation == Geo.Orientation.North then
		print("The shape is facing up")
	elseif orientation == Geo.Orientation.West then
		print("The shape is facing left")
	end
	```

	This only works for points that are determined to be a Line or Chevron.
	Every other shape does not have a facing direction. Triangles may be
	considered in the future, but for the time being they are ommitted.

	Also note that Lines use 8 cardinal directions, while Chevrons only use 4
	(N, E, S, W).

	@within Geo
	@tag core
	@param points { Vector2 } -- Array of points that compose a shape
	@return Orientation
]=]

local t = require(script.Parent.t)
local isLine = require(script.Parent.shapes.isLine)
local isChevron = require(script.Parent.shapes.isChevron)
local Orientation = require(script.Parent.Orientation)

-- Associates each cardinal angle with its equivalent in degrees. This is used
-- with finding line orientation.
local CARDINAL_ANGLES = {
	{ Orientation.East, 0 },
	{ Orientation.NorthEast, 45 },
	{ Orientation.North, 90 },
	{ Orientation.NorthWest, 135 },
	{ Orientation.West, 180 },
	{ Orientation.SouthWest, 225 },
	{ Orientation.South, 270 },
	{ Orientation.SouthEast, 360 },
}

local getLineOrientationFromAngleCheck = t.numberPositive

local function getLineOrientationFromAngle(degrees: number)
	assert(getLineOrientationFromAngleCheck(degrees))

	for i = 1, #CARDINAL_ANGLES do
		local pair = CARDINAL_ANGLES[i]
		local nextPair = CARDINAL_ANGLES[i + 1] or CARDINAL_ANGLES[1]

		if degrees > nextPair[2] then
			continue
		else
			-- Since we know that 'degrees' was bigger than nextPair[2] up to
			-- this point, we now know that the only reason we got here is
			-- because pair[2] is smaller and nextrPair[2] is bigger than
			-- 'degrees' currently. As such, we order how we take the diffs
			-- accordingly.
			local diff1 = pair[2] - degrees
			local diff2 = degrees - nextPair[2]

			if diff1 > diff2 then
				return pair[1]
			else
				return nextPair[1]
			end
		end
	end
end

local getLineOrientationCheck = t.array(t.Vector2)

local function getLineOrientation(points: { Vector2 }): string
	assert(getLineOrientationCheck(points))

	local vec = points[#points] - points[1]
	local degrees = math.deg(math.acos(vec.X / vec.Magnitude))

	-- Note! The Y axis is flipped in Roblox. Positive Y means lower on the
	-- screen, thus when 'vec' is pointing down its Y axis is positive.
	if vec.Y > 0 then
		degrees = 360 - degrees
	end

	return getLineOrientationFromAngle(degrees)
end

local getFarthestCornerCheck = t.array(t.Vector2)

local function getFarthestCorner(points: { Vector2 }): Vector2
	assert(getFarthestCornerCheck(points))

	-- Need at least 3 points to find the farthest from the start and end points.
	if #points < 3 then
		return
	end

	local first = points[1]
	local last = points[#points]
	local midpoint = (first + last) / 2

	local farthest = midpoint
	for i = 2, #points do
		local point = points[i]

		if (point - midpoint).Magnitude > (farthest - midpoint).Magnitude then
			farthest = point
		end
	end

	return farthest
end

local getChevronOrientationCheck = t.array(t.Vector2)

local function getChevronOrientation(points: { Vector2 }): string
	assert(getChevronOrientationCheck(points))

	local midpoint = (points[1] + points[#points]) / 2
	local farthest = getFarthestCorner(points)

	if math.abs(farthest.Y - midpoint.Y) > math.abs(farthest.X - midpoint.X) then
		-- Remember, Y axis is flipped in Roblox. This says "if the farthest
		-- point is above the midpoint point, then..."
		if farthest.Y < midpoint.Y then
			return Orientation.North
		else
			return Orientation.South
		end
	else
		if farthest.X > midpoint.X then
			return Orientation.East
		else
			return Orientation.West
		end
	end
end

local detectOrientationCheck = t.array(t.Vector2)

local function detectOrientation(points: { Vector2 }): string
	assert(detectOrientationCheck(points))

	if #points <= 2 then
		return
	end

	if isLine(points) then
		return getLineOrientation(points)
	elseif isChevron(points) then
		return getChevronOrientation(points)
	end
end

return detectOrientation
