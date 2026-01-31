require("misc")

terminalV = 400
gravityV = 700
maxXV = 500
slideV = 600
accV = 1300
jumpV = -500

player = {
	x = 0,
	dx = 0,
	y = 0,
	dy = 0,
	w = 50,
	h = 90,
	airborne = true,
	pressedAOrD = false,
	facingRight = false,
	sprites = {
		love.graphics.newImage("Assets/Player/stand.png")
	},
	load = function()
		player.x = 0
		player.y = 0--windowH - player.h
	end,
	update = function(dt)
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

		if love.keyboard.isDown("a") then
			player.dx = math.min(0, player.dx - dt*accV)
			player.pressedAOrD = true
		end
		if love.keyboard.isDown("d") then
			player.dx = math.max(0, player.dx + dt*accV)
			player.pressedAOrD = true
		end
		player.x = player.x + player.dx * dt
		player.y = player.y + player.dy * dt

		local slideX = player.pressedAOrD and 1 or 2
		player.dx = mid(-maxXV, mid(player.dx + slideV*slideX*dt, 0, player.dx - slideV*slideX*dt), maxXV)
		player.y = mid(0, player.y, windowH-groundH-player.h)
		if player.dx > 0 then player.facingRight = true 
		elseif player.dx < 0 then player.facingRight = false end
	end,
	draw = function()
		img(player.sprites[1], player.x + (player.facingRight and player.w or 0), player.y, 0, 2*(player.facingRight and -1 or 1), 2)

		-- TESTING

		--rect(player.x, player.y, player.w, player.h, {1,1,1})
		--text(player.dx, player.x, player.y - 30, 12, {1,1,1})
	end
}

return player