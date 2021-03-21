local sortCounterClockwise = require(script.Parent.sortCounterClockwise)
local getConvexHull = require(script.Parent.getConvexHull)
local getPerimeter = require(script.Parent.getPerimeter)
local getPolygonArea = require(script.Parent.getPolygonArea)
local getBoundingBox = require(script.Parent.getBoundingBox)
local getLargestTriangle = require(script.Parent.getLargestTriangle)
local getSideLengths = require(script.Parent.getSideLengths)
local getTriangleArea = require(script.Parent.getTriangleArea)
local isLine = require(script.Parent.isLine)
local isChevron = require(script.Parent.isChevron)
local Shape = require(script.Parent.Shape)

local LINE_THRESHHOLD = 30
local SQUARE_PERCENT = 0.60
local RECTANGLE_PERCENT = 0.75
local TRIANGLE_PERCENT = 0.75

local CIRCLE = 4 * math.pi

local function fuzzyeq(a, b, epsilon)
	return math.abs(a - b) <= epsilon
end

local function detectShape(points: {[number]: Vector2})
	if isLine(points) then
		return Shape.Line
	elseif isChevron(points) then
		return Shape.Chevron
	end

	local sorted = sortCounterClockwise(points)
	local hull = getConvexHull(sorted)

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
	if fuzzyeq(CIRCLE, thinnessRatio, 1) and triangleRatio < TRIANGLE_PERCENT then
		return Shape.Circle
	elseif squareRatio >= SQUARE_PERCENT then
		return Shape.Square
	elseif rectangleRatio >= RECTANGLE_PERCENT then
		return Shape.Rectangle
	elseif thinnessRatio >= LINE_THRESHHOLD then
		return Shape.Line
	elseif triangleRatio >= TRIANGLE_PERCENT then
		return Shape.Triangle
	end
end

return detectShape
