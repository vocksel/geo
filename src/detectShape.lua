local sortCounterClockwise = require(script.Parent.sortCounterClockwise)
local getConvexHull = require(script.Parent.getConvexHull)
local getPolygonArea = require(script.Parent.getPolygonArea)
local isLine = require(script.Parent.shapes.isLine)
local isChevron = require(script.Parent.shapes.isChevron)
local isCircle = require(script.Parent.shapes.isCircle)
local isRectangle = require(script.Parent.shapes.isRectangle)
local isSquare = require(script.Parent.shapes.isSquare)
local isTriangle = require(script.Parent.shapes.isTriangle)
local Shape = require(script.Parent.Shape)

local function detectShape(points: {[number]: Vector2})
	if isLine(points) then
		return Shape.Line
	elseif isChevron(points) then
		return Shape.Chevron
	end

	local sorted = sortCounterClockwise(points)
	local hull = getConvexHull(sorted)
	local hullArea = getPolygonArea(hull)

	if isCircle(hull, hullArea) then
		return Shape.Circle
	elseif isSquare(hull, hullArea) then
		return Shape.Square
	elseif isRectangle(hull, hullArea) then
		return Shape.Rectangle
	elseif isTriangle(hull, hullArea) then
		return Shape.Triangle
	end
end

return detectShape
