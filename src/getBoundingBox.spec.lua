return function()
	local getBoundingBox = require(script.Parent.getBoundingBox)

	it("should return the same points if given 4 or less points", function()
		for i = 0, 3 do
			local points = {}

			for _ = 0, i do
				table.insert(points, Vector2.new(i, i))
			end

			expect(getBoundingBox(points)).to.equal(points)
		end
	end)

	it("should always return 4 points", function()
		local points = {}
		for i = 1, 20 do
			-- Generate random points along a sin curve. When run through
			-- getBoundingBox() the resulting 4 points will represent a
			-- rectangle that is 2 units.
			local formula = (math.pi / 2) * i
			local x = math.cos(formula)
			local y = math.sin(formula)
			table.insert(points, Vector2.new(x, y))
		end

		local box = getBoundingBox(points)

		expect(box[4].Y - box[1].Y).to.equal(2)
		expect(#box).to.equal(4)
	end)
end
