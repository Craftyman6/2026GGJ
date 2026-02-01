local class = require("middleclass")
enemyData = require("Enemy.enemyData")
require("Projectile.enemyProjectile")

Enemy = class('Enemy')

function Enemy:initialize(x, y, id)
	self.time = 0
	self.x = x
	self.y = y
	self.id = id
	local data = enemyData[id]
	self.w = data.w
	self.h = data.h
	self.timeSinceShoot = 0
	self.cooldown = data.cooldown
	self.update = data.update
	self.health = data.health

	self.spritesheet = data.spritesheet
	self.sprites = {
		love.graphics.newQuad(0, 0, self.w, self.h, self.spritesheet),
		love.graphics.newQuad(self.w, 0, self.w, self.h, self.spritesheet)
	}
	self.sprite = self.sprites[1]

	if self.timeSinceShoot > self.cooldown then
		table.insert(allProjectiles, EnemyProjectile:new(self.x, self.y, self.id))
	end

	if self.id == 1 then -- There's no enemy of type 1
	elseif self.id == 2 then self:waterInitialize()
	elseif self.id == 3 then self:jugglerInitialize()
	elseif self.id == 4 then self:chefInitialize()
	elseif self.id == 5 then self:flyInitialize()
	end
end

function Enemy:waterInitialize()
	self.dx = -100
end
function Enemy:jugglerInitialize()
	self.dx = -50
	self.timeTillTurn = 1
end
function Enemy:chefInitialize()
	self.dx = 300
end
function Enemy:flyInitialize()
	self.dx = -70
end

function Enemy:update(dt)
	-- Die if out of health
	if self.health <= 0 then
		-- drop mask
		table.insert(allMasks, Mask:new(self.x, self.y, self.id))
		return true
	end
	self.time = self.time + dt
	self.timeSinceShoot = self.timeSinceShoot + dt

	if self.x < 0 then self.dx = math.abs(self.dx)
	elseif self.x > roomW-self.w then self.dx = -math.abs(self.dx) end

	self.x = self.x + self.dx * dt
	--self.y = math.min(self.y + 400*dt, windowH-groundH-self.h)

	if self.timeSinceShoot > self.cooldown then
		table.insert(allProjectiles, EnemyProjectile:new(self.x, self.y, self.id))
		self.timeSinceShoot = 0
	end

	if self.id == 1 then -- There's no enemy of type 1
	elseif self.id == 2 then -- Water guy doesn't need special code
	elseif self.id == 3 then self:jugglerUpdate(dt)
	elseif self.id == 4 then self:chefUpdate(dt)
	elseif self.id == 5 then self:flyUpdate(dt)
	end
end

function Enemy:waterUpdate(dt)
	self.sprite = self.sprites[math.floor(1 + (self.time % 2))]
end
function Enemy:jugglerUpdate(dt)
	self.timeTillTurn = self.timeTillTurn - dt
	if self.timeTillTurn < 0 then
		self.dx = -self.dx
		self.timeTillTurn = 1 + math.random()
	end
end
function Enemy:chefUpdate(dt)
	self.sprite = self.sprites[math.floor(1 + (5*self.time % 2))]
end
function Enemy:flyUpdate(dt)
	self.sprite = self.sprites[math.floor(1 + (3*self.time % 2))]
end

function Enemy:draw()
	-- Sprite
	love.graphics.setColor(1,1,1)
	love.graphics.draw(self.spritesheet, self.sprite,
	self.x + (self.dx > 0 and self.w or 0), self.y, 0,
	self.dx > 0 and -1 or 1, 1)
	-- Health bar
	line(self.x, self.y - 10, math.max(1, self.x + self.health*4), self.y - 10, 2, {1,0,0})
	if hitboxes then drawHitbox(self) end
end