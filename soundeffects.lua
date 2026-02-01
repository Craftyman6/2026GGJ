require("misc")

soundeffect = {
	load = function()
		--Projectiles
		ballFX = love.audio.newSource("Assets/SoundEffects/ball.mp3", "static")
		crowbarFX = love.audio.newSource("Assets/SoundEffects/crowbar.mp3", "static")
		laserFX = love.audio.newSource("Assets/SoundEffects/laser.mp3", "static")
		rareCrowbarFX = love.audio.newSource("Assets/SoundEffects/rareCrowbar.mp3", "static")
		--Character
		jumpFX = love.audio.newSource("Assets/SoundEffects/jump.mp3", "static")
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
	jump = function()
		local pitch = 0.9 + math.random() * 0.2
		jumpFX:setPitch(pitch)
		jumpFX:play()
	end,
}
return soundeffect