require("misc")

player = {
	x = 0,
	y = 0,
	w = 60,
	h = 100,
	load = function()
		player.x = 0
		player.y = windowH - player.h
	end,
	update = function()

	end,
	draw = function()
		rect(player.x, player.y, player.w, player.h, {1,1,1})
	end
}

return player