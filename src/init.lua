return {
    -- Core API
    detectShape = require(script.detectShape),
	getOrientation = require(script.getOrientation),
    Shape = require(script.Shape),
	Orientation = require(script.Orientation),

    -- Helpers
	sortCounterClockwise = require(script.sortCounterClockwise),
    getConvexHull = require(script.getConvexHull),
    getCornerIndices = require(script.getCornerIndices),
    getBoundingBox = require(script.getBoundingBox),
    getLargestTriangle = require(script.getLargestTriangle),
    getPerimeter = require(script.getPerimeter),
    getPolygonArea = require(script.getPolygonArea),
    getSideLengths = require(script.getSideLengths),
    getTriangleArea = require(script.getTriangleArea),
}
