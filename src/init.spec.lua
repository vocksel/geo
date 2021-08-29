return function()
	it("should require without erroring", function()
		expect(function()
			require(script.Parent)
		end).to.never.throw()
	end)
end
