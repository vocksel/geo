local ReplicatedStorage = game:GetService("ReplicatedStorage")

local getPerimeter = require(ReplicatedStorage.shared.geometry.getPerimeter)
local getPolygonArea = require(ReplicatedStorage.shared.geometry.getPolygonArea)
local getBoundingBox = require(ReplicatedStorage.shared.geometry.getBoundingBox)
local getLargestTriangle = require(ReplicatedStorage.shared.geometry.getLargestTriangle)
local getSideLengths = require(ReplicatedStorage.shared.geometry.getSideLengths)
local getTriangleArea = require(ReplicatedStorage.shared.geometry.getTriangleArea)
local Shape = require(script.Parent.Shape)

local LINE_THRESHHOLD = 30
local SQUARE_PERCENT = 0.60
local RECTANGLE_PERCENT = 0.75
local TRIANGLE_PERCENT = 0.75

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
