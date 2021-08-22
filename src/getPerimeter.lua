--[[
	Gets the perimeter of a convex object. Only use this with points that have a
	defined shape, such as a rectangle or convex hull. If there are excess
	points you will get incorrect results
]]

local t = require(script.Parent.t)

local check = t.array(t.Vector2)

local function getPerimeter(points: { Vector2 })
	assert(check(points))

	if #points == 1 then
		return 0
	elseif #points == 2 then
		return (points[1] - points[2]).Magnitude
	end

	local perimeter = 0
	for i = 2, #points do
		perimeter += (points[i - 1] - points[i]).Magnitude
	end
	return perimeter
end

return getPerimeter
