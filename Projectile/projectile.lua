local class = require("middleclass")
require("misc")
projectileData = require("Projectile.projectileData")

Projectile = class('Projectile')

function Projectile:initialize(x, y, id, facingRight, airborne)
	self.time = 0
	self.x = x
	self.y = y
	self.id = id
	self.facingRight = facingRight
	self.airborne = airborne
	local data = projectileData[id]
	self.w = data.w
	self.h = data.h
	self.dmg = data.dmg
	self.spritesheet = data.spritesheet
	self.sprites = {
		love.graphics.newQuad(0, 0, self.w, self.h, self.spritesheet),
		love.graphics.newQuad(self.w, 0, self.w, self.h, self.spritesheet),
		love.graphics.newQuad(0, self.h, self.w, self.h, self.spritesheet),
		love.graphics.newQuad(self.w, self.h, self.w, self.h, self.spritesheet)
	}
	self.sprite = self.sprites[1]

	if self.id == 1 then self:crowbarInitialize()
	elseif self.id == 2 then self:waterInitialize()
	elseif self.id == 3 then self:ballInitialize() end
end

-- Projectile specific initializing
function Projectile:crowbarInitialize()
	-- No horizontal movement if in air, a lot of horizontal movement if on ground
	self.dx = 10 * (self.airborne and 0 or (self.facingRight and 1 or -1))
	-- Send it down if in air, or up if on ground
	self.dy = self.airborne and 8 or (-3 - math.random())
end
function Projectile:waterInitialize()
	-- Random speed
	self.speed = math.random()*200 + 400
end
function Projectile:ballInitialize()
	-- Randomize x
	self.x = self.x + math.random()*player.w
	-- Fully horizontal if in the air, only a little if grounded
	self.dx = (self.facingRight and 1 or -1) * (self.airborne and 500 or 100) * (math.random()/2+.5)
	-- No vertical if in the air, fully verticle if grounded
	self.dy = (self.airborne and 0 or -500)
	-- Set sprite
	self.sprite = self.sprites[1+math.floor(math.random()*4)]
end

function Projectile:update(dt)
	-- Update time
	self.time = self.time + dt
	-- Hitting enemies
	for i, enemy in ipairs(allEnemies) do
		if hitboxesTouching(self, enemy) then
			enemy.health = enemy.health - self.dmg
			return true
		end
	end
	-- Projectile updating
	if self.id == 1 then return self:crowbarUpdate(dt)
	elseif self.id == 2 then return self:waterUpdate(dt)
	elseif self.id == 3 then return self:ballUpdate(dt) end
end

function Projectile:crowbarUpdate(dt)
	-- Physics
	self.dy = self.dy + 10*dt
	self.x = self.x + self.dx
	self.y = self.y + self.dy

	-- Sprite
	self.sprite = self.sprites[1+math.floor(4*self.time % 4)]

	-- Delete when touching ground
	return self.y > windowH-groundH-self.h
end
function Projectile:waterUpdate(dt)
	-- Physics
	self.x = self.x + self.speed * dt * (self.facingRight and 1 or -1)
	self.y = self.y + (self.airborne and 100*dt or 0)

	-- Sprite
	if self.time < .2 then self.sprite = self.sprites[1]
	elseif self.time < .4 then self.sprite = self.sprites[2]
	else
		self.sprite = self.sprites[3+math.floor(4*(self.time % .5))]
	end

	-- Delete when alive for two seconds
	return self.time > 2
end
function Projectile:ballUpdate(dt)
	-- Physics
	self.x = self.x + self.dx * dt
	self.dy = self.dy + 500*dt
	self.y = self.y + self.dy * dt

	-- Delete when below floor
	return self.y > windowH-groundH
end

function Projectile:draw()
	love.graphics.setColor(1,1,1)
	love.graphics.draw(self.spritesheet, self.sprite, 
	self.x + (self.facingRight and 0 or self.w), self.y, 0,
	self.facingRight and 1 or -1, 1)
	if hitboxes then drawHitbox(self) end
end