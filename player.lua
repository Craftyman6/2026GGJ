require("misc")

terminalV = 300
gravityV = 200
maxXV = 500
slideV = 600
accV = 1300

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
			player.y = player.y + player.dy * dt
			player.dy = player.dy + dt*gravityV
			if player.y + player.h >= windowH - groundH then
				player.airborne = false
			end
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

		local slideX = player.pressedAOrD and 1 or 2
		player.x = mid(0, player.x, windowW-player.w)
		player.dx = mid(-maxXV, mid(player.dx + slideV*slideX*dt, 0, player.dx - slideV*slideX*dt), maxXV)
		player.y = mid(0, player.y, windowH-groundH-player.h)
		player.dy = math.min(terminalV, player.dy)
	end,
	draw = function()
		rect(player.x, player.y, player.w, player.h, {1,1,1})
		text(player.dx, player.x, player.y - 30, 12, {1,1,1})
	end
}

return player