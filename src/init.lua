--[=[
	@class Geo

	The functions tagged with `core` are the primary API of this package. All
	others are helpers that are used in conjunction with the core API, but have
	been exposed since they can be useful in contexts that are not related to
	shape recognition.
]=]

return {
	-- Core API
	detectShape = require(script.detectShape),
	detectOrientation = require(script.detectOrientation),
	Orientation = require(script.Orientation),
	Shape = require(script.Shape),

	-- Helpers
	getBoundingBox = require(script.getBoundingBox),
	getConvexHull = require(script.getConvexHull),
	getCornerIndices = require(script.getCornerIndices),
	getLargestTriangle = require(script.getLargestTriangle),
	getPerimeter = require(script.getPerimeter),
	getPolygonArea = require(script.getPolygonArea),
	getSideLengths = require(script.getSideLengths),
	getTriangleArea = require(script.getTriangleArea),
	isLine = require(script.shapes.isLine),
	isChevron = require(script.shapes.isChevron),
	sortCounterClockwise = require(script.sortCounterClockwise),
}
