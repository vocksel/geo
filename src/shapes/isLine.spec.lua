return function()
	local isLine = require(script.Parent.isLine)

	it("should return true for any 2 points", function()
		expect(isLine({ Vector2.new(0, 0), Vector2.new(10, 0) })).to.equal(true)
		expect(isLine({ Vector2.new(10, 0), Vector2.new(0, 10) })).to.equal(true)
		expect(isLine({ Vector2.new(-100, 0), Vector2.new(0, 100) })).to.equal(true)
	end)

	it("should return true if 3 points are close enough to a straight line", function()
		local points = {
			Vector2.new(0, 0),
			Vector2.new(10, 5),
			Vector2.new(20, 0),
		}

		expect(isLine(points)).to.equal(true)
	end)

	it("should return false if one point is too far away", function()
		local points = {
			Vector2.new(0, 0),
			Vector2.new(10, 100),
			Vector2.new(20, 0),
			Vector2.new(30, 0),
		}

		expect(isLine(points)).to.equal(false)
	end)

	it("should return false if given less than 2 points", function()
		expect(isLine({ Vector2.new(0, 0) })).to.equal(false)
		expect(isLine({})).to.equal(false)
	end)
end
