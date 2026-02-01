require("misc")
require("mask")
soundeffect = require("soundeffects")

terminalV = 400
gravityV = 700
maxXV = 500
slideV = 600
accV = 1300
jumpV = -500
projectileData = require("Projectile.projectileData")

player = {
	x = 60,
	dx = 0,
	y = 0,
	dy = 0,
	w = 50,
	h = 90,
	time = 0,
	airborne = true,
	airSound = true,
	pressedAOrD = false,
	facingRight = true,
	sprite = 1,
	timeSinceShoot = 0,
	stamina = 50,
	maxStamina = 50,
	masks = {Mask:new(0, 0, 1)},
	iFrames = 0,
	maxIFrames = 1,
	sprites = {
		love.graphics.newImage("Assets/Player/stand.png"),
		love.graphics.newImage("Assets/Player/step1.png"),
		love.graphics.newImage("Assets/Player/step2.png"),
		love.graphics.newImage("Assets/Player/jump1.png"),
		love.graphics.newImage("Assets/Player/jump2.png")
	},
	-- Returns top mask
	getMask = function()
		return player.masks[#player.masks]
	end,
	getMaskID = function()
		return player.masks[#player.masks].id
	end,
	load = function()
		player.x = 60
		player.y = windowH - groundH - player.h
	end,
	jump = function()
		player.airborne = true
		player.dy = jumpV
		player.airSound = false
	end,
	update = function(dt)
		-- Time variables
		player.time = player.time + dt
		player.timeSinceShoot = player.timeSinceShoot + dt
		player.iFrames = math.max(0, player.iFrames - dt)

		-- Jumping
		player.pressedAOrD = false
		if player.airborne then
			local down = love.keyboard.isDown("s")
			local up = love.keyboard.isDown("w")
			player.dy = down and math.max(player.dy, 0) or player.dy
			player.dy = player.dy + dt*gravityV*(down and 2 or 1)*(up and .5 or 1)
			if player.y + player.h >= windowH - groundH then
				player.airborne = false
				player.airSound = true
			end
		elseif love.keyboard.isDown("w") then	
			if player.airSound then
				soundeffect.jump()
			end
			player.jump()
		end

		-- Horizontal Movement
		if love.keyboard.isDown("a") then
			player.dx = math.min(0, player.dx - dt*accV)
			player.pressedAOrD = true
		end
		if love.keyboard.isDown("d") then
			player.dx = math.max(0, player.dx + dt*accV)
			player.pressedAOrD = true
		end

		-- Projectiles
		if #player.masks > 0 then
			player.stamina = math.min(player.maxStamina, player.stamina + dt*15)
			local projectile = projectileData[player.getMaskID()]
			if love.keyboard.isDown("space") and 
			player.timeSinceShoot > projectile.cooldown and
			player.stamina > projectile.stamina then
				player.timeSinceShoot = 0
				player.stamina = player.stamina - projectile.stamina
				table.insert(allProjectiles, Projectile:new(player.x, player.y, player.getMaskID(), player.facingRight, player.airborne))
			end
		end

		-- Physics
		player.x = player.x + player.dx * dt
		player.y = player.y + player.dy * dt

		-- Horizontal speed cap and sliding
		local slideX = player.pressedAOrD and 1 or 2
		player.dx = mid(-maxXV, mid(player.dx + slideV*slideX*dt, 0, player.dx - slideV*slideX*dt), maxXV)

		-- Bound player
		player.x = mid(0, player.x, roomW - player.w)
		player.y = mid(0, player.y, windowH-groundH-player.h)
		if player.dx > 0 then player.facingRight = true 
		elseif player.dx < 0 then player.facingRight = false end

		-- Sprite
		player.sprite = not player.airborne and
			(math.abs(player.dx) > 130 and 
				2 + (math.floor(5*player.time%2)) 
			or 
				1)
		or
			(player.dy > 1 and
				5
			or
				4)

		-- Mask
		if #player.masks > 0 then player.getMask():setPosition(player.x + 10, player.y + 9.5) end
	end,
	hit = function()
		if player.iFrames <= 0 then
			local lostMask = Mask:new(player.x, player.y - 50, table.remove(player.masks, #player.masks).id)
			lostMask.time = lostMask.ttl - .5
			soundeffect:hit()
			table.insert(allMasks, lostMask)
			player.iFrames = 3
		end
	end,
	draw = function()
		-- Sprite
		if player.iFrames <= 0 or player.time%.2 > .1 then
			img(player.sprites[player.sprite], player.x + (player.facingRight and player.w or 0), player.y, 0, 2*(player.facingRight and -1 or 1), 2)
		end
		-- Mask
		if #player.masks > 0 then
			player.getMask():draw(.6) 
			-- Stamina
			if player.stamina < player.maxStamina then
				local projectile = projectileData[player.getMaskID()]
				local staminaCol = ({{1,0,0},{0,1,0},{.8,.9,0}})[player.stamina > projectile.stamina and (player.timeSinceShoot > projectile.cooldown and 2 or 3) or 1]
				line(player.x, player.y - 10, player.x + player.stamina + 1, player.y - 10, 2, staminaCol)
			end
		end
		-- TESTING
		--rect(player.x, player.y, player.w, player.h, {1,1,1})
		--text(player.dx, player.x, player.y - 30, 12, {1,1,1})
	end
}

return player
