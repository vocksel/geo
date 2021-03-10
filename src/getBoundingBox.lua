--[[
	Based on a series of 4+ points, 4 new points that represent the minimum
	bounding box are returned.

	The resulting rectangle is axis-aligned. This is important because we want
	the user to specifically draw squares/rectangles that are aligned vertically
	and horizontally. If either was rotated, the user would most likely be
	drawing a diamon shape, which we don't want.
]]

local function getBoundingBox(points)
	if #points <= 4 then
		return points
	end

	local xmin = math.huge
	local xmax = 0
	local ymin = math.huge
	local ymax = 0

	for _, point in ipairs(points) do
		xmin = math.min(point.X, xmin)
		xmax = math.max(point.X, xmax)
		ymin = math.min(point.Y, ymin)
		ymax = math.max(point.Y, ymax)
	end

	return {
		Vector2.new(xmin, ymin),
		Vector2.new(xmax, ymin),
		Vector2.new(xmax, ymax),
		Vector2.new(xmin, ymax),
	}
end

return getBoundingBox
