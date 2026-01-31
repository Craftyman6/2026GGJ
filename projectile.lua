local class = require("middleclass")
require("misc")

Projectile = class('Projectile')

function Projectile:initialize(x, y, image)
	self.x = x
	self.y = y
	self.image = image
end

function Projectile:load()
	
end

function Projectile:update()
	self.x = self.x + 2
end

function Projectile:draw()
	rect(self.x, self.y, 25, 25, {0,1,0})
end