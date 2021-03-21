return {
    -- Core API
    sortCounterClockwise = require(script.sortCounterClockwise),
    getConvexHull = require(script.getConvexHull),
    detectShape = require(script.detectShape),
    Shape = require(script.Shape),

    -- Helpers
    getCornerIndices = require(script.getCornerIndices),
    getBoundingBox = require(script.getBoundingBox),
    getLargestTriangle = require(script.getLargestTriangle),
    getPerimeter = require(script.getPerimeter),
    getPolygonArea = require(script.getPolygonArea),
    getSideLengths = require(script.getSideLengths),
    getTriangleArea = require(script.getTriangleArea),
}
