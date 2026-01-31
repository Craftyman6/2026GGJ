local class = require("middleclass")

Projectile = class('Projectile')

function Projectile:initialize(x, y, image)
	self.x = x
	self.y = y
	self.image = image
end

function Projectile:load()
	self.image = love.graphics.newImage("Assets/background.png")
end

function Projectile:update()
		
end

function Projectile:draw()
	love.graphics.draw(background.image, background.x, 0, 0, 1, 1)
end