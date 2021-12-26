--[=[
	@function detectShape

	Given an ordered list of points, this function determines the best possible
	shape that the points represent. Returns a Shape enum that you can use for
	comparison with `Geo.Shape`

	Since Geo is a library for analyzing drawn shapes, the points should be in
	order of when they were drawn for best results.

	```lua
	local points = { Vector2.new(x1, y1), Vector2.new(x2, y2), Vector2.new(x3, y3), ... }

	if detectShape(points) == Geo.Shape.Line then
		print("The hull represents a line")
	end
	```

	This function makes a distinction between squares and rectangles. If you do
	not care which one you get, a conditional that includes both cases is your
	best course of action.

	@within Geo
	@tag core
	@param points { Vector2 } -- Array of points to detect the shape of
	@return Shape -- Returns the Shape of the
]=]

local t = require(script.Parent.t)
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

local check = t.array(t.Vector2)

local function detectShape(points: { [number]: Vector2 })
	assert(check(points))

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
