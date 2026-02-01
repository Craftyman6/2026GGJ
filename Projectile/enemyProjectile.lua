local class = require("middleclass")
require("misc")
enemyProjectileData = require("Projectile.enemyProjectileData")

EnemyProjectile = class('EnemyProjectile')

-- extra is a table of extra variables for type specific stuff
function EnemyProjectile:initialize(x, y, id)
	self.time = 0
	self.x = x
	self.y = y
	self.id = id
	local data = enemyProjectileData[id]
	self.w = data.w
	self.h = data.h
	self.spritesheet = data.spritesheet
	self.sprites = {
		love.graphics.newQuad(0, 0, self.w, self.h, self.spritesheet),
		love.graphics.newQuad(self.w, 0, self.w, self.h, self.spritesheet),
		love.graphics.newQuad(0, self.h, self.w, self.h, self.spritesheet),
		love.graphics.newQuad(self.w, self.h, self.w, self.h, self.spritesheet)
	}
	self.sprite = self.sprites[1]

	if self.id == 1 then -- There's no enemy of type 1
	elseif self.id == 2 then self:waterInitialize()
	elseif self.id == 3 then self:ballInitialize()
	elseif self.id == 4 then self:fireInitialize()
	elseif self.id == 5 then self:flowerInitialize()
	end
end

function EnemyProjectile:waterInitialize()
	self.x = self.x + 30
	self.y = windowH-groundH-self.h
	-- 75% chance to throw projectile towards player
	self.dx = math.random() > (player.x > self.x and .75 or .25) and -200 or 200
end
function EnemyProjectile:ballInitialize()
	self.dx = math.random()*300 - 150
	self.dy = -500
	self.sprite = self.sprites[1+math.floor(math.random()*4)]
end
function EnemyProjectile:fireInitialize()
	self.ttl = 4
	self.y = windowH-groundH-self.h
end
function EnemyProjectile:flowerInitialize()
	self.dx = math.random()*250 - 125
	self.dy = 30
end

function EnemyProjectile:update(dt)
	-- Update time
	self.time = self.time + dt
	-- Hit player
	if hitboxesTouching(self, player) then
		player.hit()
		return true
	end
	-- Projectile updating
	if self.id == 1 then return -- There's no enemy of type 1
	elseif self.id == 2 then return self:waterUpdate(dt)
	elseif self.id == 3 then return self:ballUpdate(dt)
	elseif self.id == 4 then return self:fireUpdate(dt)
	elseif self.id == 5 then return self:flowerUpdate(dt)
	end
end

function EnemyProjectile:waterUpdate(dt)
	-- Move horizontally
	self.x = self.x + self.dx * dt
	-- Bounce off walls
	if self.x < 0 then self.dx = math.abs(self.dx)
	elseif self.x > roomW-self.w then self.dx = -math.abs(self.dx) end
	-- Sprite
	self.sprite = self.sprites[1+math.floor(3*self.time%4)]
	-- Delete after 3 seconds
	return self.time > 2.5
end
function EnemyProjectile:ballUpdate(dt)
	-- Move horizontally
	self.x = self.x + self.dx * dt
	-- Move laterally
	self.dy = self.dy + dt*500
	self.y = self.y + self.dy * dt
	-- Bounce off walls
	if self.x < 0 then self.dx = math.abs(self.dx)
	elseif self.x > roomW-self.w then self.dx = -math.abs(self.dx) end
	-- Delete after going past floor
	return self.y > windowH-groundH
end
function EnemyProjectile:fireUpdate(dt)
	-- Sprite
	if self.ttl - self.time > .5 then
		self.sprite = self.sprites[1+math.floor(4*self.time%2)]
	else
		self.sprite = self.sprites[self.ttl - self.time > .25 and 3 or 4]
	end
	-- Delete if out of time
	return self.time >= self.ttl
end
function EnemyProjectile:flowerUpdate(dt)
	-- Move horizontally
	self.x = self.x + self.dx * dt
	-- Move laterally
	self.dy = self.dy + dt*20
	self.y = self.y + self.dy * dt
	-- Sprite
	self.sprite = self.sprites[1+math.floor(2*self.time%4)]
	-- Delete after going past floor
	return self.y > windowH-groundH
end

function EnemyProjectile:draw()
	love.graphics.setColor(1,1,1)
	love.graphics.draw(self.spritesheet, self.sprite, 
	self.x + (self.facingRight and 0 or self.w), self.y, 0,
	self.facingRight and 1 or -1, 1)
	if hitboxes then drawHitbox(self) end
end