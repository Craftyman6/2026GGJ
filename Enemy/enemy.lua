local class = require("middleclass")
enemyData = require("Enemy.enemyData")

Enemy = class('Enemy')

function Enemy:initialize(x, y, id)
	self.x = x
	self.y = y
	self.id = id
	local data = enemyData[id]
	self.w = data.w
	self.h = data.h
	self.update = data.update
end

function Enemy:update(dt)
	if self.id == 1 then
		self.x = self.x - 100*dt
		self.y = math.min(windowH-groundH-self.h, self.y + 200*dt)
	end
end

function Enemy:draw()
	rect(self.x, self.y, self.w, self.h, {1,1,1})
end