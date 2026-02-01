projectileData = {
	-- 1: extra
	{
	},
	-- 2: Water
	{
		w = 40,
		h = 20,
		spritesheet = love.graphics.newImage("Assets/EnemyProjectile/water.png")
	},
	-- 2: Ball
	{
		w = 10,
		h = 10,
		spritesheet = love.graphics.newImage("Assets/Projectiles/ball.png")
	},
	-- 2: Fire
	{
		w = 30,
		h = 10,
		spritesheet = love.graphics.newImage("Assets/EnemyProjectile/fire.png")
	},
	-- 2: Flower
	{
		w = 15,
		h = 15,
		spritesheet = love.graphics.newImage("Assets/EnemyProjectile/flower.png")
	}
}

return projectileData