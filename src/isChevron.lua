local getCornerIndices = require(script.Parent.getCornerIndices)

type Array<T> = { [number]: T }

local function isChevron(points: Array<Vector2>): Array<number>
	local corners = getCornerIndices(points, 120)
	local first = points[1]
	local last = points[#points]

	-- If there aren't any corners than the points can not represent a chevron.
	-- It's more likely that the user drew a line, or some malformed shape.
	if #corners == 0 then return false end

	-- When the start and end are too close together, it's more likely that the
	-- user tried to draw a triangle than a chevron.
	if (first - last).Magnitude < 100 then return false end

	return true
end

return isChevron
