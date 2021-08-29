-- The absolute path to TestEZ must be used so that this script can work with
-- run-in-roblox in CI.
local TestEZ = require(game.ServerScriptService.Tests.TestEZ)

local results = TestEZ.TestBootstrap:run({
	game.ReplicatedStorage.Geo,
}, TestEZ.Reporters.TextReporterQuiet)

if results.failureCount > 0 then
	print("❌ Test run failed")
else
	print("✔️ All tests passed")
end
