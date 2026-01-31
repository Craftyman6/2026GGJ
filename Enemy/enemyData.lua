enemyData = {
	-- 1: empty
	{
	},
	-- 2: Water
	{
		w = 100,
		h = 80,
		cooldown = 1,
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
	}
}

return enemyData