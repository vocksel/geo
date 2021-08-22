-- The absolute path to TestEZ must be used so that this script can work in
-- Studio normally, and when using run-in-roblox in CI.
local TestEZ = require(game.ServerScriptService.Tests.TestEZ)

TestEZ.TestBootstrap:run({
	game.ReplicatedStorage.Geo,
})
