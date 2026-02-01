require("misc")

background = {
	bground = "",
	forground = "",
	x = 0,
	load = function()
		background.bground = love.graphics.newImage("Assets/Background/palace.jpg")
		background.forground = love.graphics.newImage("Assets/Background/columns.png")
	end,
	update = function()
		
	end,
	draw = function()
		love.graphics.draw(background.forground, background.x, 0, 0, 3, 1)
	end,
	drawBack = function()
		love.graphics.draw(background.bground, background.x, 0, 0, 3, 2.5)
	end
}

return background