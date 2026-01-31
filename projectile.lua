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

end

function Projectile:draw()
	rect(self.x, self.y, 25, 25, {0,0,0})
end