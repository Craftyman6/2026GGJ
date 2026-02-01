require("misc")

soundeffect = {
	load = function()
		--Projectiles
		ballFX = love.audio.newSource("Assets/SoundEffects/ball.mp3", "static")
		ballFX:setVolume(0.6)
		crowbarFX = love.audio.newSource("Assets/SoundEffects/crowbar.mp3", "static")
		crowbarFX:setVolume(0.35)
		laserFX = love.audio.newSource("Assets/SoundEffects/laser.mp3", "static")
		rareCrowbarFX = love.audio.newSource("Assets/SoundEffects/rareCrowbar.mp3", "static")
		fireFX = love.audio.newSource("Assets/SoundEffects/fire.mp3", "static")
		fireFX:setVolume(.70)
		flowerFX = love.audio.newSource("Assets/SoundEffects/flower.mp3", "static")
		maskFX = love.audio.newSource("Assets/SoundEffects/mask.mp3", "static")
		--Character
		jumpFX = love.audio.newSource("Assets/SoundEffects/jump.mp3", "static")
		jumpFX:setVolume(0.45)
	end,
	update = function()
		
	end,
	crowbar = function()
		random = math.random(1000)		
		local pitch = 0.9 + math.random() * 0.2
		crowbarFX:setPitch(pitch)
		if random == 1000 then
			rareCrowbarFX:play()
		else
			crowbarFX:play()
		end
	end,
	ball = function()
		local pitch = 0.9 + math.random() * 0.2
		ballFX:setPitch(pitch)
		ballFX:play()
	end,
	laser = function()
		local pitch = 0.9 + math.random() * 0.2
		laserFX:setPitch(pitch)
		laserFX:play()
	end,
	flower = function()
		local pitch = 0.9 + math.random() * 0.2
		flowerFX:setPitch(pitch)
		flowerFX:play()
	end,
	fire = function()
		fireFX:play()
	end,
	mask = function()
		maskFX:play()
	end,
	jump = function()
		local pitch = 0.9 + math.random() * 0.2
		jumpFX:setPitch(pitch)
		jumpFX:play()
	end,
}
return soundeffect