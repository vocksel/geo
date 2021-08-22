local getBoundingBox = require(script.Parent.Parent.getBoundingBox)
local getSideLengths = require(script.Parent.Parent.getSideLengths)

local RECTANGLE_PERCENT = 0.75

local function isRectangle(hull: { Vector2 }, hullArea: number)
	local rectangle = getBoundingBox(hull)
	local sides = getSideLengths(rectangle)
	local rectangleArea = sides.X * sides.Y

	return hullArea / rectangleArea >= RECTANGLE_PERCENT
end

return isRectangle
