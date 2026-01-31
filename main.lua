windowW = 1280
windowH = 720
groundH = 20
roomW = 2500
camX = 0
player = require("player")
Camera = require "CameraMgr".newManager()
background = require("background")
require("Enemy.enemy")
require("Projectile.projectile")
allEnemies = {}
allProjectiles = {}

function love.load()
	love.window.setMode(windowW, windowH)
	background.load()
	player.load()
	testEnemy = Enemy:new(1000, 0, 1)
end

function love.update(dt)
	player.update(dt)

	-- Have to iterate backwards to removing doesn't screw up
	for i = #allProjectiles, 1, -1 do
		if allProjectiles[i]:update(dt) then
			table.remove(allProjectiles, i)
		end
	end
	moveCamera(dt)
	Camera.update(dt)
	testEnemy:update(dt)
end

function love.draw()
	Camera.attach()

	background.draw()
	rectLine(1,1, roomW-1, windowH-1, {1,1,1})
	player.draw()
	testEnemy:draw()

	for i, projectile in ipairs(allProjectiles) do
		projectile:draw()
	end

	Camera.detach()
end

function moveCamera(dt)
	camX = mid(640, roomW - 640, easeTo(camX, player.x + 100, 10*dt * math.abs(player.x + 100 - camX)))


	Camera.setCoords(camX, 360)
end