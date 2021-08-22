--[[
	Given a list of Vector2s, this function uses the Graham Scan algorithm to
	iterate over them and return a new array of Vector2s which are the ones that
	create a convex hull around the entire list of points.

	Remember to call sortCounterClockwise() on your list of points before
	passing them in!
]]

local function cross(a, b, c)
	return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
end

local function getConvexHull(points: { [number]: Vector2 })
	local hull = { points[1], points[2] }

	for i = 3, #points do
		local point = points[i]

		-- This filters out colinear points by comparing the current point with
		-- the last one. Vector2 comparison checks if the X and Y components of
		-- each is the same, rather than checking if the instances are the same.
		if point == hull[#hull] then
			continue
		end

		-- If the next turn is clockwise, this will continue removing points
		-- from the end of the hull until the last point in the hull makes a
		-- counterclockwise turn to `point`.
		while cross(hull[#hull - 1], hull[#hull], point) > 0 do
			table.remove(hull, #hull)

			if #hull == 1 then
				break
			end
		end

		table.insert(hull, point)
	end

	return hull
end

return getConvexHull
