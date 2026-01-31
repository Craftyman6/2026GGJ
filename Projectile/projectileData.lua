
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
	-- 2: Ball
	{
		w = 10,
		h = 10,
		cooldown = .1,
		dmg = .5,
		stamina = 3,
		spritesheet = love.graphics.newImage("Assets/Projectiles/ball.png")
	}
}

return projectileData