require("misc")

background = {
	image = "",
	x = 0,
	load = function()
		background.image = love.graphics.newImage("Assets/background.png")
	end,
	update = function()
		background.x = background.x - 1
	end,
	draw = function()
		love.graphics.draw(background.image, background.x, 0, 0, 1, 1)
	end
}

return background