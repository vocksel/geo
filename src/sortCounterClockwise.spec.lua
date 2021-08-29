return function()
	local sortCounterClockwise = require(script.Parent.sortCounterClockwise)

	it("should sort a list of points in counterclockwise order", function()
		-- https://www.desmos.com/calculator/atvolzmilh
		local points = {
			Vector2.new(5, 2),
			Vector2.new(2, 3),
			Vector2.new(8, 4),

			-- Bigger Y coordinate means a point is further down the screen.
			-- This becomes the anchor.
			Vector2.new(0, 5),
		}

		local sorted = sortCounterClockwise(points)

		expect(sorted[1]).to.equal(points[4])
		expect(sorted[2]).to.equal(points[3])
		expect(sorted[3]).to.equal(points[1])
		expect(sorted[4]).to.equal(points[2])
	end)

	it("should use the rightmost point when Y coordinates are tied", function()
		-- https://www.desmos.com/calculator/2nvr3pow7c
		local points = {
			Vector2.new(2, 2),
			Vector2.new(8, 3),
			-- The anchor point is the lowest point that is furthest to the
			-- right, so this point should become the anchor.
			Vector2.new(8, 5),
		}

		local sorted = sortCounterClockwise(points)

		expect(sorted[1]).to.equal(points[3])
	end)

	it("should return a new table", function()
		local points = {
			Vector2.new(0, 0),
			Vector2.new(1, 1),
			Vector2.new(2, 2),
		}

		local sorted = sortCounterClockwise(points)

		expect(points).to.never.equal(sorted)
	end)
end
