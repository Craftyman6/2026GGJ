hitboxes = false

windowW = 1280
windowH = 720
groundH = 20
-- For reference, a room width of 1280 would be a room the size of the screen (the camera would never move)
roomW = 2500
camX = 0
player = require("player")
Camera = require "CameraMgr".newManager()
background = require("background")
soundeffect = require("soundeffects")
map = require("map")
death = require("death")
require("Enemy.enemy")
require("mask")
require("Projectile.projectile")
allEnemies = {}
allProjectiles = {}
allMasks = {}

function love.load()
	love.window.setMode(windowW, windowH)
	background.load()
	map.load()
	player.load()
	soundeffect.load()
	song = love.audio.newSource("Assets/Music/song.mp3", "stream")
	song:setLooping(true)
    love.audio.play(song)
end

function love.update(dt)
	player.update(dt)
	map.update(dt)
	death.update(dt)

	-- Have to iterate backwards so removing doesn't screw up
	for i = #allProjectiles, 1, -1 do
		if allProjectiles[i]:update(dt) then
			table.remove(allProjectiles, i)
		end
	end
	for i = #allMasks, 1, -1 do
		if allMasks[i]:update(dt) then
			table.remove(allMasks, i)
		end
	end
	for i = #allEnemies, 1, -1 do
		if allEnemies[i]:update(dt) then
			table.remove(allEnemies, i)
		end
	end
	moveCamera(dt)
	Camera.update(dt)
end

function love.draw()
	local cx, cy = Camera.getCoords()

	love.graphics.push()
	love.graphics.setColor(1,1,1)

	local backFactor = 0.3

	love.graphics.translate(-cx * backFactor, -cy * backFactor)

	background.drawBack()

	local backFactor = 0.4

	love.graphics.translate(-cx * backFactor, -cy * backFactor)

	background.drawColumns()

	love.graphics.pop()

	Camera.attach()
	rectLine(1,1, roomW-1, windowH-1, {1,1,1})

	for i, projectile in ipairs(allProjectiles) do
		projectile:draw()
	end
	for i, mask in ipairs(allMasks) do
		mask:draw(1)
	end
	for i, enemy in ipairs(allEnemies) do
		enemy:draw(1)
	end
	player.draw()
	map.drawTutorial()

	Camera.detach()

	-- Health
	for i, mask in ipairs(player.masks) do
		local y = 25 + 3*#player.masks*math.sin(player.time/#player.masks*5+i) + 3*#player.masks
		img(mask.sprite, 10, y)
	end
	-- Death message
	if #player.masks == 0 then
		death.drawWarn()
	end

	local tileSpacing = 40
	local floorDisX = -camX%(tileSpacing*2)
	for i = -3, 32 do
		local col = i%2 == 0 and {.816, .784, .675} or {.71, .678, .569}
		rect(tileSpacing*i + floorDisX,
		windowH-groundH,
		tileSpacing,
		groundH, col)
	end
end

function moveCamera(dt)
	camX = mid(640, roomW - 640, easeTo(camX, player.x + 100, 10*dt * math.abs(player.x + 100 - camX)))


	Camera.setCoords(camX, 360)
end

-- TESTING
--[[
function love.mousepressed(x, y, button)
	table.insert(allMasks, Mask:new(x, y, 5))
end
]]