return function()
	local sortCounterClockwise = require(script.Parent.Parent.sortCounterClockwise)
	local getConvexHull = require(script.Parent.Parent.getConvexHull)
	local getPolygonArea = require(script.Parent.Parent.getPolygonArea)
	local isRectangle = require(script.Parent.isRectangle)

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

		expect(isRectangle(hull, hullArea)).to.equal(false)
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

		expect(isRectangle(hull, hullArea)).to.equal(true)
	end)

	it("should return true if given a rectangle", function()
		local points = {
			Vector2.new(0, 0),
			Vector2.new(5, 0),
			Vector2.new(5, 10),
			Vector2.new(0, 10),
		}

		local sorted = sortCounterClockwise(points)
		local hull = getConvexHull(sorted)
		local hullArea = getPolygonArea(hull)

		expect(isRectangle(hull, hullArea)).to.equal(true)
	end)

	it("should return true if given a very skinny rectangle", function()
		local points = {
			Vector2.new(0, 0),
			Vector2.new(2, 0),
			Vector2.new(2, 20),
			Vector2.new(0, 20),
		}

		local sorted = sortCounterClockwise(points)
		local hull = getConvexHull(sorted)
		local hullArea = getPolygonArea(hull)

		expect(isRectangle(hull, hullArea)).to.equal(true)
	end)
end
