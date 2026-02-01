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
	-- 3: Ball
	{
		w = 10,
		h = 10,
		spritesheet = love.graphics.newImage("Assets/Projectiles/ball.png")
	},
	-- 4: Fire
	{
		w = 30,
		h = 10,
		spritesheet = love.graphics.newImage("Assets/EnemyProjectile/fire.png")
	},
	-- 5: Flower
	{
		w = 15,
		h = 15,
		spritesheet = love.graphics.newImage("Assets/EnemyProjectile/flower.png")
	},
	-- 6: Chandelier
	{
		w = 300,
		h = 150,
		spritesheet = love.graphics.newImage("Assets/EnemyProjectile/chandelier.png")
	},
	-- 7: Shard
	{
		w = 40,
		h = 20,
		spritesheet = love.graphics.newImage("Assets/EnemyProjectile/shard.png")
	}
}

return projectileData