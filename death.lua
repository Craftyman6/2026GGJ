death = {
	time = 0,
	update  = function(dt)
		death.time = death.time + dt
		if #player.masks == 0 then
			player.iFrames = 100
			if player.x < 1 then
				love.event.push("quit", "restart")
			end
		end
	end,
	drawWarn = function()
		for i = 0, 1 do
			text("You're out of masks!\nMake a break for it!",
			390, 300 + i*2, 50, {i,i,i})
			text("<--",
			410 + math.cos(death.time*10)*10, 430 + i*2, 50, {i,i,i})
		end
	end,
	die = function()

	end
}

return death