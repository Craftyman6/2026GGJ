local class = require("middleclass")
require("misc")
require("map")

Mask = class('Mask')

maskSprites = {
	love.graphics.newImage("Assets/Mask/burglar.png"),
	love.graphics.newImage("Assets/Mask/water.png"),
	love.graphics.newImage("Assets/Mask/juggle.png"),
	love.graphics.newImage("Assets/Mask/fire.png"),
	love.graphics.newImage("Assets/Mask/fly.png")
}

function Mask:initialize(x, y, id)
	self.time = 0
	self.ttl = 10
	self.x = x
	self.y = y
	self.w = 50
	self.h = 30
	self.id = id
	self.sprite = maskSprites[id]
	self.dx = map.currentRoomID == 1 and -200 or math.random()*600 - 300
	self.dy = -1500
	self.grounded = false
end

-- Update is only called if the mask object is dropped
-- (won't be called when the player has them)
function Mask:update(dt)
	-- Update time
	self.time = self.time + dt
	-- Delete if out of time
	if self.time > self.ttl then return true end

	-- Physics
	if self.grounded then
		self.dy = 0
		self.y = windowH-groundH-self.h
	else
		self.dy = self.dy + 3000*dt
		-- Bounce
		if self.y > windowH-groundH-self.h then
			self.dy = 700 - self.dy
			self.y = windowH-groundH-self.h-1
			if self.dy >= 0 then self.grounded = true end
		end
	end
	if self.x < 0 then self.dx = math.abs(self.dx)
	elseif self.x > roomW-self.w then self.dx = -math.abs(self.dx) end
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt

	-- Collect
	if hitboxesTouching(self, player) then
		self.time = 0
		table.insert(player.masks, self)
		return true
	end
end

-- now THIS is what's called when its worn
function Mask:setPosition(x, y)
	self.x = x
	self.y = y
end

-- Takes a size parameter so it can be drawn smaller when on face and larger when dropped
function Mask:draw(s)
	if self.ttl - self.time > 1 or self.time%.2 > .1 then
		img(self.sprite, self.x, self.y, 0, s)
	end
	if hitboxes then drawHitbox(self) end
end