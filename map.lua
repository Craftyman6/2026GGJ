-- Enemy list contains enemy creation parameters {x, y, id}
music = require("music")
rooms = {
	-- Room 1 (just a juggler)
	{
		w = 2000,
		enemies = {
			{1800, 0, 3},
		}
	},
	-- Room 2 (just a water)
	{
		w = 1500,
		enemies = {
			{500, 0, 2}
		}
	},
	-- Room 3 (2 water, juggler, fly)
	{
		w = 1500,
		enemies = {
			{1200, 0, 2},
			{1500, 0, 2},
			{1000, 0, 3},
			{2000, 0, 5}
		}
	},
	-- Room 4 (small room with chef)
	{
		w = 1280,
		enemies = {
			{400, 0, 4}
		}
	},
	-- Room 5 (large room with one of everyone)
	{
		w = 2000,
		enemies = {
			{500, 0, 3},
			{1000, 0, 2},
			{1500, 0, 5},
			{2000, 0, 4}
		}
	},
	-- Room 6 (king)
	{
		w = 1280,
		enemies = {
			{500, 0, 6}
		}
	},
	-- Room 7 (bonus)
	{
		w = 1600,
		enemies = {
			-- Filled in load
		}
	}
}

map = {
	time = 0,
	currentRoom = rooms[1],
	currentRoomID = 1,
	finishMusic = true,
	loadRoom = function()
		roomW = map.currentRoom.w
		camX = 0
		player.x = 0
		allProjectiles = {}
		allEnemyProjectiles = {}
		allEnemies = {}
		for i, enemy in ipairs(map.currentRoom.enemies) do
			table.insert(allEnemies, Enemy:new(unpack(enemy)))
		end
		if map.currentRoomID == 1 then
			music.level_0()
		elseif map.currentRoomID == 2 then
			music.level_1()
		elseif map.currentRoomID == 3 then
			music.level_2()
		elseif map.currentRoomID == 4 then
			love.audio.stop()
			music.level_3()
		elseif map.currentRoomID == 6 then
			music.level_boss()
		end
	end,
	progressRoom = function()
		map.currentRoomID = map.currentRoomID + 1
		map.currentRoom = rooms[map.currentRoomID]
		map.loadRoom()
	end,
	load = function()
		for i = 2, 5 do
			for j = 1, 3 do
				table.insert(rooms[7].enemies, {math.random()*1500, 0, i})
			end
		end
		map.loadRoom()
	end,
	update = function(dt)
		map.time = map.time + dt
		if player.x >= roomW-player.w-1 then
			if map.currentRoomID == 6 then
				if #allEnemies == 0 then 
					map.progressRoom()
				end
			elseif map.currentRoomID == 7 then return
				love.event.push("quit", "restart")
			else
				map.progressRoom()
			end
		end
	end,
	-- oh and also boss screen textd
	drawTutorial = function()
		for i = 0, 1 do
			if map.currentRoomID == 1 then
				text("Masker Raid",
				50, 50 + i*2, 80, {i*.9,0,0})
				text("This masquerade's got cooler masks than any of your burglar masks at home.\nLet's resort to stealing!",
				50, 150 + i*2, 30, {i,i,i})
				text("Use A and D to move, and SPACE to attack.",
				50, 250 + i*2, 30, {i,i,i})
				text("Your attacks use stamina, so don't use it all at once!",
				50, 340 + i*2, 30, {i,i,i})
				if #allEnemies == 0 then 
					text("After defeating maskers, you can take\ntheir mask!",
					1300, 50 + i*2, 30, {i,i,i})
					text("Masks not only protect you from hits...\nbut give you special attacks!",
					1300, 150 + i*2, 30, {i,i,i})
					text("You'll always have the ability of your\nfront mask. Check the top left of\nthe screen see your mask stack.",
					1300, 250 + i*2, 30, {i,i,i})
					text("Continue right to proceed.",
					1300, 400 + i*2, 30, {i,i,i})
				else
					text("Look! A masker!",
					1300, 50 + i*2, 30, {i,i,i})
					text("Throw your crowbar at him without getting\nhit by his attacks.",
					1300, 150 + i*2, 30, {i,i,i})
				end
			elseif map.currentRoomID == 2 then
				if #allEnemies == 0 then 
					text("One last thing. Press S in the air\nto drop!",
					500, 50 + i*2, 30, {i,i,i})
					text("Once you've mastered jumping,\nnothing can stop you!",
					500, 150 + i*2, 30, {i,i,i})
				else
					text("Oh yeah, press W to jump!",
					50, 50 + i*2, 30, {i,i,i})
					text("Your attacks throw differently\nin the air, try it out!",
					50, 150 + i*2, 30, {i,i,i})
				end
			elseif map.currentRoomID == 6 then
				if #allEnemies == 0 then 
					text("Thanks for playing!",
					300, 200 + i*2, 70, {i,i,i})
					text("Masker Raid | A Global Game Jam 2026 submission by:\n           Colin Schaffner & Logan Faulstich",
					90, 350 + i*2, 40, {i,i,i})
				else
					text("Mask King",
					450, 50 + i*2, 90, {i,math.cos(map.time/2),math.sin(map.time/2)})
				end
			end
		end
	end
}

return map