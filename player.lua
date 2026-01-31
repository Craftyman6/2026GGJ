require("misc")

terminalV = 400
gravityV = 700
maxXV = 500
slideV = 600
accV = 1300
jumpV = -500
projectileData = require("Projectile.projectileData")

player = {
	x = 0,
	dx = 0,
	y = 0,
	dy = 0,
	w = 50,
	h = 90,
	time = 0,
	airborne = true,
	pressedAOrD = false,
	facingRight = false,
	sprite = 1,
	timeSinceShoot = 0,
	stamina = 50,
	maxStamina = 50,
	sprites = {
		love.graphics.newImage("Assets/Player/stand.png"),
		love.graphics.newImage("Assets/Player/step1.png"),
		love.graphics.newImage("Assets/Player/step2.png"),
		love.graphics.newImage("Assets/Player/jump1.png"),
		love.graphics.newImage("Assets/Player/jump2.png")
	},
	load = function()
		player.x = 0
		player.y = 0--windowH - player.h
	end,
	update = function(dt)
		-- Time variables
		player.time = player.time + dt
		player.timeSinceShoot = player.timeSinceShoot + dt

		-- Jumping
		player.pressedAOrD = false
		if player.airborne then
			local down = love.keyboard.isDown("s")
			local up = love.keyboard.isDown("w")
			player.dy = down and math.max(player.dy, 0) or player.dy
			player.dy = player.dy + dt*gravityV*(down and 2 or 1)*(up and .5 or 1)
			if player.y + player.h >= windowH - groundH then
				player.airborne = false
			end
		elseif love.keyboard.isDown("w") then
			player.airborne = true
			player.dy = jumpV
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
		player.stamina = math.min(player.maxStamina, player.stamina + dt*15)
		local projectile = projectileData[getMaskID()]
		if love.keyboard.isDown("space") and 
		player.timeSinceShoot > projectile.cooldown and
		player.stamina > projectile.stamina then
			player.timeSinceShoot = 0
			player.stamina = player.stamina - projectile.stamina
			table.insert(allProjectiles, Projectile:new(player.x, player.y, getMaskID(), player.facingRight, player.airborne))
		end

		-- Physics
		player.x = player.x + player.dx * dt
		player.y = player.y + player.dy * dt

		-- Horizontal speed cap and sliding
		local slideX = player.pressedAOrD and 1 or 2
		player.dx = mid(-maxXV, mid(player.dx + slideV*slideX*dt, 0, player.dx - slideV*slideX*dt), maxXV)

		-- Bound player
		player.x = mid(0, player.x, roomW)
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
	end,
	draw = function()
		-- Sprite
		img(player.sprites[player.sprite], player.x + (player.facingRight and player.w or 0), player.y, 0, 2*(player.facingRight and -1 or 1), 2)
		-- Stamina
		if player.stamina < player.maxStamina then
			local staminaCol = ({{1,0,0},{0,1,0}})[player.stamina > projectileData[getMaskID()].stamina and 2 or 1]
			line(player.x, player.y - 10, player.x + player.stamina + 1, player.y - 10, 2, staminaCol)
		end
		-- TESTING
		--rect(player.x, player.y, player.w, player.h, {1,1,1})
		--text(player.dx, player.x, player.y - 30, 12, {1,1,1})
	end
}

function getMaskID()
	return 1
end

return player
