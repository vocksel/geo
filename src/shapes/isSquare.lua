local t = require(script.Parent.Parent.t)
local getBoundingBox = require(script.Parent.Parent.getBoundingBox)
local getSideLengths = require(script.Parent.Parent.getSideLengths)

local SQUARE_PERCENT = 0.60

local check = t.tuple(t.array(t.Vector2), t.numberPositive)

local function isSquare(hull: { Vector2 }, hullArea: number)
	assert(check(hull, hullArea))

	if #hull < 4 then
		return false
	end

	local rectangle = getBoundingBox(hull)
	local sides = getSideLengths(rectangle)
	local maxSide = math.max(sides.X, sides.Y)

	return hullArea / maxSide ^ 2 >= SQUARE_PERCENT
end

return isSquare
