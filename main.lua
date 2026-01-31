windowW = 1280
windowH = 720
groundH = 20
player = require("player")
Camera = require "CameraMgr".newManager()
background = require("background")
require("projectile")
projectile = Projectile:new(0, 0, "Assets/Projectiles/projectile.jpg")

function love.load()
	love.window.setMode(windowW, windowH)
	background.load()
	player.load()
end

function love.update(dt)
	player.update(dt)
	Camera.setCoords(player.x, 360)
	Camera.update(dt)
end

function love.draw()
	Camera.attach()

	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", 0, 0, 500, 500)
	love.graphics.setColor(1,1,1)
	love.graphics.print("hello!", 250, 250)
	rectLine(0, 0, windowW, windowH, {1,1,1})
	background.draw()
	projectile:draw()
	player.draw()
	Camera.detach()
end
