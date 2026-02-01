require("misc")

background = {
	bground = "",
	forground = "",
	x = 0,
	load = function()
		background.bground = love.graphics.newImage("Assets/Background/bg.png")
		background.forground = love.graphics.newImage("Assets/Background/columns.png")
	end,
	update = function()
		
	end,
	drawColumns = function()
		love.graphics.draw(background.forground, background.x + 640, 252, 0, 1, 1)
	end,
	drawBack = function()
		love.graphics.draw(background.bground, background.x, 110, 0, 1, 1)
	end
}

return background