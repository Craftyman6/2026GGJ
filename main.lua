function love.load()
	love.window.setMode(500, 500)
end

function love.update()

end

function love.draw()
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill", 0, 0, 500, 500)
	love.graphics.setColor(1,1,1)
	love.graphics.print("hello!", 250, 250)
end