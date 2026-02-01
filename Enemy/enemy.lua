local class = require("middleclass")
enemyData = require("Enemy.enemyData")
require("Projectile.enemyProjectile")
enemyProjectileData = require("Projectile.enemyProjectileData")
music = require("music")
soundeffect = require("soundeffects")

Enemy = class('Enemy')

function Enemy:initialize(x, y, id)
	self.time = 0
	self.x = x
	self.id = id
	local data = enemyData[id]
	self.w = data.w
	self.h = data.h
	self.y = windowH-groundH-self.h
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
	elseif self.id == 6 then self:kingInitialize()
	end
end

function Enemy:waterInitialize()
	self.dx = map.currentRoomID == 2 and 50 or -80
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
	self.y = 30
end
function Enemy:kingInitialize()
	self.dx = 80
end

function Enemy:update(dt)
	-- Die if out of health
	if self.health <= 0 then
		soundeffect:die()
		if self.id == 6 then
			allProjectiles = {}
			for i = 0, 11 do
				table.insert(allMasks, Mask:new(
				self.x + math.random()*self.w,
				self.y + math.random()*self.h/2,
				math.floor(i/3)+2))
			end
			music.level_finish()
		else
			-- drop mask
			table.insert(allMasks, Mask:new(self.x + math.random()*self.w, self.y+math.random()*self.h/2, self.id))
		end
		return true
	end
	self.time = self.time + dt
	self.timeSinceShoot = self.timeSinceShoot + dt

	if self.x < 0 then self.dx = math.abs(self.dx)
	elseif self.x > roomW-self.w then self.dx = -math.abs(self.dx) end

	self.x = self.x + self.dx * dt
	--self.y = math.min(self.y + 400*dt, windowH-groundH-self.h)

	if self.timeSinceShoot > self.cooldown then
		if self.id == 6 then
			chandelier = enemyProjectileData[6]
			table.insert(allProjectiles, EnemyProjectile:new(
			math.random()*(roomW+2*chandelier.w)-chandelier.w,
			-chandelier.h, self.id))
		else
			table.insert(allProjectiles, EnemyProjectile:new(self.x, self.y, self.id))
		end
		self.timeSinceShoot = 0
	end

	if self.id == 1 then -- There's no enemy of type 1
	elseif self.id == 2 then self:waterUpdate(dt)
	elseif self.id == 3 then self:jugglerUpdate(dt)
	elseif self.id == 4 then self:chefUpdate(dt)
	elseif self.id == 5 then self:flyUpdate(dt)
	elseif self.id == 6 then self:kingUpdate(dt)
	end
end

function Enemy:waterUpdate(dt)
	self.sprite = self.sprites[math.floor(1 + (self.time % 2))]
end
function Enemy:jugglerUpdate(dt)
	self.sprite = self.sprites[math.floor(1 + (5*self.time % 2))]
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
function Enemy:kingUpdate(dt)
	self.sprite = self.sprites[math.floor(1 + (4*self.time % 2))]
	self.cooldown = 1 + self.health/100
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