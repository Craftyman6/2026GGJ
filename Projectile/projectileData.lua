
--[[
cooldown: How often can you throw it?
stamina: How much stamina does it use?
dmg: How much damage does it do?
]]

projectileData = {
	-- 1: Crowbar
	{
		w = 40,
		h = 40,
		cooldown = 1,
		dmg = 2,
		stamina = 20,
		spritesheet = love.graphics.newImage("Assets/Projectiles/crowbar.png")
	},
	-- 2: Water
	{
		w = 25,
		h = 25,
		cooldown = .2,
		dmg = 1,
		stamina = 6,
		spritesheet = love.graphics.newImage("Assets/Projectiles/water.png")
	},
	-- 3: Ball
	{
		w = 10,
		h = 10,
		cooldown = .1,
		dmg = .5,
		stamina = 3,
		spritesheet = love.graphics.newImage("Assets/Projectiles/ball.png")
	},
	-- 4: Fire
	{
		w = 10,
		h = 10,
		cooldown = .03,
		dmg = .4,
		stamina = 1.5,
		spritesheet = love.graphics.newImage("Assets/Projectiles/fire.png")
	},
	-- 5: Flower
	{
		w = 150,
		h = 150,
		cooldown = 1.5,
		dmg = 4,
		stamina = 30,
		spritesheet = love.graphics.newImage("Assets/Projectiles/flower.png")
	}
}

return projectileData