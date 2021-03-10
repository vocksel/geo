local getPerimeter = require(script.Parent.getPerimeter)
local getPolygonArea = require(script.Parent.getPolygonArea)
local getBoundingBox = require(script.Parent.getBoundingBox)
local getLargestTriangle = require(script.Parent.getLargestTriangle)
local getSideLengths = require(script.Parent.getSideLengths)
local getTriangleArea = require(script.Parent.getTriangleArea)

local enums = {
	Line = "Line",
	Circle = "Circle",
	Square = "Square",
	Rectangle = "Rectangle",
	Triangle = "Triangle",
}

local function range(lower, upper)
	return function(n)
		return lower < n and n < upper
	end
end

local lineThreshold = range(20, 30)
local squareThreshold = range(0.50, 0.60)
local rectangleThreshold = range(0.60, 0.75)
local triangleThreshold = range(0.60, 0.75)

local CIRCLE = 4 * math.pi

local function fuzzyeq(a, b, epsilon)
	return math.abs(a - b) <= epsilon
end

local function detectShape(hull: {[number]: Vector2})
	local hullArea = getPolygonArea(hull)
	local perimeter = getPerimeter(hull)

	local rectangle = getBoundingBox(hull)
	local sides = getSideLengths(rectangle)
	local rectangleArea = sides.X * sides.Y
	local maxSide = math.max(sides.X, sides.Y)

	local triangle = getLargestTriangle(hull)
	local triangleArea = getTriangleArea(unpack(triangle))

	-- Goes to infinity for lines and approaches 4pi for circles.
	local thinnessRatio = perimeter^2 / hullArea
	-- Approaches unity
	local squareRatio = hullArea / maxSide^2
	-- Approaches unity
	local rectangleRatio = hullArea / rectangleArea
	-- Approaches unity
	local triangleRatio = triangleArea / hullArea

	-- print("thinnessRatio", thinnessRatio)
	-- print("squareRatio", squareRatio)
	-- print("rectangleRatio", rectangleRatio)
	-- print("triangleRatio", triangleRatio)

	-- Triangles tend to have a thinnessRatio that approaches 4pi, so we also
	-- compare with the triangleRatio to ensure we detect the correct shape/
	if fuzzyeq(CIRCLE, thinnessRatio, 1) and triangleRatio < triangleThreshold then
		return enums.Circle
	elseif squareThreshold(squareRatio) then
		return enums.Square
	elseif rectangleThreshold(rectangleRatio) then
		return enums.Rectangle
	elseif lineThreshold(thinnessRatio) then
		return enums.Line
	elseif triangleThreshold(triangleRatio) then
		return enums.Triangle
	end
end

return detectShape
