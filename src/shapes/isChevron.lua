--[=[
	@function isChevron

	Checks if a series of points represent a Chevron shape by calculating the
	sharp corners and where the points start and end.

	@within Geo
	@tag helper
	@param points { Vector2 }
	@return boolean -- Returns true if the points represent a Chevron. False otherwise.
]=]

local t = require(script.Parent.Parent.t)
local getCornerIndices = require(script.Parent.Parent.getCornerIndices)

local check = t.array(t.Vector2)

local function isChevron(points: { Vector2 }): { number }
	assert(check(points))

	local corners = getCornerIndices(points, 120)
	local first = points[1]
	local last = points[#points]

	-- If there aren't any corners than the points can not represent a chevron.
	-- It's more likely that the user drew a line, or some malformed shape.
	if #corners == 0 then
		return false
	end

	-- When the start and end are too close together, it's more likely that the
	-- user tried to draw a triangle than a chevron.
	if (first - last).Magnitude < 100 then
		return false
	end

	return true
end

return isChevron
