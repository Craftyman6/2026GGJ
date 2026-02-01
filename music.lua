require("misc")

music = {
	load = function()
		level0 = love.audio.newSource("Assets/Music/level_0.mp3", "stream")
		level0:setLooping(true)
		level1 = love.audio.newSource("Assets/Music/level_1.mp3", "stream")
		level1:setLooping(true)
		level2 = love.audio.newSource("Assets/Music/level_2.mp3", "stream")
		level2:setLooping(true)
		level3 = love.audio.newSource("Assets/Music/level_3.mp3", "stream")
		level3:setLooping(true)
		boss = love.audio.newSource("Assets/Music/level_boss.mp3", "stream")
		boss:setLooping(true)
		finish = love.audio.newSource("Assets/Music/level_finish.mp3", "stream")
		finish:setLooping(true)
	end,
	update = function()
		
	end,
	level_0 = function()
		love.audio.stop()
		level0:play()
	end,
	level_1 = function()
		love.audio.stop()
		love.audio.play(level1)
	end,
	level_2 = function()
		love.audio.stop()
		love.audio.play(level2)
	end,	
	level_3 = function()
		love.audio.play(level3)
	end,
	level_boss = function()
		love.audio.stop()
		love.audio.play(boss)
	end,
	level_finish = function()
		love.audio.stop()
		love.audio.play(finish)
	end
}
return music