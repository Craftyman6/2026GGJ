enemyData = {
	-- 1: empty
	{
	},
	-- 2: Water
	{
		w = 100,
		h = 80,
		cooldown = 1.9,
		health = 10,
		spritesheet = love.graphics.newImage("Assets/Enemy/water.png")
	},
	-- 3: Juggler
	{
		w = 60,
		h = 100,
		cooldown = .3,
		health = 7,
		spritesheet = love.graphics.newImage("Assets/Enemy/juggler.png")
	},
	-- 4: Chef
	{
		w = 60,
		h = 70,
		cooldown = 1.4,
		health = 8,
		spritesheet = love.graphics.newImage("Assets/Enemy/chef.png")
	},
	-- 5: Fly
	{
		w = 80,
		h = 90,
		cooldown = 2,
		health = 5,
		spritesheet = love.graphics.newImage("Assets/Enemy/fly.png")
	},
	-- 6: King
	{
		w = 200,
		h = 400,
		cooldown = .5,
		health = 80,
		spritesheet = love.graphics.newImage("Assets/Enemy/king.png")
	}
}

return enemyData