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
	w = 60,
	h = 100,
	airborne = true,
	pressedAOrD = false,
	load = function()
		player.x = 0
		player.y = 0--windowH - player.h
	end,
	update = function(dt)
		player.pressedAOrD = false
		if player.airborne then
			local down = love.keyboard.isDown("s")
			local up = love.keyboard.isDown("space")
			player.dy = down and math.max(player.dy, 0) or player.dy
			player.dy = player.dy + dt*gravityV*(down and 2 or 1)*(up and .5 or 1)
			if player.y + player.h >= windowH - groundH then
				player.airborne = false
			end
		elseif love.keyboard.isDown("space") then
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
		--player.dy = math.min(terminalV, player.dy)
	end,
	draw = function()
		rect(player.x, player.y, player.w, player.h, {1,1,1})
		text(player.dx, player.x, player.y - 30, 12, {1,1,1})
	end
}

return player