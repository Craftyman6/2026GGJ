require("middleclass")

projectile = {
	image = "",
	x = 0,
	load = function()
		background.image = love.graphics.newImage("Assets/background.png")
	end,
	update = function()
		
	end,
	draw = function()
		love.graphics.draw(background.image, background.x, 0, 0, 1, 1)
	end
}

return projectile