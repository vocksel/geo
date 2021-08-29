local t = require(script.Parent.Parent.t)
local getBoundingBox = require(script.Parent.Parent.getBoundingBox)
local getSideLengths = require(script.Parent.Parent.getSideLengths)
local isSquare = require(script.Parent.isSquare)

local RECTANGLE_PERCENT = 0.75

local check = t.tuple(t.array(t.Vector2), t.numberPositive)

local function isRectangle(hull: { Vector2 }, hullArea: number)
	assert(check(hull, hullArea))

	if #hull < 4 then
		return false
	end

	if isSquare(hull, hullArea) then
		return true
	end

	local rectangle = getBoundingBox(hull)
	local sides = getSideLengths(rectangle)
	local rectangleArea = sides.X * sides.Y

	return hullArea / rectangleArea >= RECTANGLE_PERCENT
end

return isRectangle
