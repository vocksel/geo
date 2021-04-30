local getBoundingBox = require(script.Parent.Parent.getBoundingBox)
local getSideLengths = require(script.Parent.Parent.getSideLengths)

local SQUARE_PERCENT = 0.60

local function isSquare(hull: { Vector2 }, hullArea: number)
	local rectangle = getBoundingBox(hull)
	local sides = getSideLengths(rectangle)
	local maxSide = math.max(sides.X, sides.Y)

	return hullArea / maxSide^2 >= SQUARE_PERCENT
end

return isSquare