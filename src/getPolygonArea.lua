--[[
	Gets the area of any polygon.

	This is specifically used to find the area of the convex hull, but it can be
	used in conjunction with anything so long as the points are in clockwise or
	conterclockwise order.
]]

local function getPolygonArea(points)
	local area = 0

	for i, point in ipairs(points) do
		local nextPoint = points[i + 1] or points[1]
		area += point:Cross(nextPoint)
	end

	return math.abs(area / 2)
end

return getPolygonArea
