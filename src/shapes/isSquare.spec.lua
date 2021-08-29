return function()
	local sortCounterClockwise = require(script.Parent.Parent.sortCounterClockwise)
	local getConvexHull = require(script.Parent.Parent.getConvexHull)
	local getPolygonArea = require(script.Parent.Parent.getPolygonArea)
	local isSquare = require(script.Parent.isSquare)

	it("should return false if given less than 4 points", function()
		-- https://www.desmos.com/calculator/gay2ou3an9
		local points = {
			Vector2.new(0, 0),
			Vector2.new(0, 5),
			Vector2.new(5, 0),
		}

		local sorted = sortCounterClockwise(points)
		local hull = getConvexHull(sorted)
		local hullArea = getPolygonArea(hull)

		expect(isSquare(hull, hullArea)).to.equal(false)
	end)

	it("should return true if given a square", function()
		-- https://www.desmos.com/calculator/u0qqdblmrg
		local points = {
			Vector2.new(0, 0),
			Vector2.new(0, 5),
			Vector2.new(5, 5),
			Vector2.new(5, 0),
		}

		local sorted = sortCounterClockwise(points)
		local hull = getConvexHull(sorted)
		local hullArea = getPolygonArea(hull)

		expect(isSquare(hull, hullArea)).to.equal(true)
	end)

	it("should return true if given a shape that roughly resembles a square", function()
		-- https://www.desmos.com/calculator/um3zmbazlq
		local points = {
			Vector2.new(0, 0),
			Vector2.new(3, 0),
			Vector2.new(8, 1),
			Vector2.new(0, 3),
			Vector2.new(0.5, 8),
			Vector2.new(3, 8),
			Vector2.new(8, 7),
		}

		local sorted = sortCounterClockwise(points)
		local hull = getConvexHull(sorted)
		local hullArea = getPolygonArea(hull)

		expect(isSquare(hull, hullArea)).to.equal(true)
	end)

	it("should return false if given a square with an outlier", function()
		local points = {
			Vector2.new(0, 0),
			Vector2.new(0, 5),
			Vector2.new(5, 5),
			Vector2.new(5, 0),
			Vector2.new(100, 0),
		}

		local sorted = sortCounterClockwise(points)
		local hull = getConvexHull(sorted)
		local hullArea = getPolygonArea(hull)

		expect(isSquare(hull, hullArea)).to.equal(false)
	end)

	it("should return false if given a rectangle", function()
		local points = {
			Vector2.new(0, 0),
			Vector2.new(5, 0),
			Vector2.new(5, 10),
			Vector2.new(0, 10),
		}

		local sorted = sortCounterClockwise(points)
		local hull = getConvexHull(sorted)
		local hullArea = getPolygonArea(hull)

		expect(isSquare(hull, hullArea)).to.equal(false)
	end)
end
