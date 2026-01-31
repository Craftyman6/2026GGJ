windowW = 1280
windowH = 720
player = require("player")

function love.load()
	love.window.setMode(windowW, windowH)
	player.load()
end

function love.update()

end

function love.draw()
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", 0, 0, 500, 500)
	love.graphics.setColor(1,1,1)
	love.graphics.print("hello!", 250, 250)
	player.draw()
end