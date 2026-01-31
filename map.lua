-- Enemy list contains enemy creation parameters {x, y, id}
rooms = {
	-- Room 1
	{
		w = 2500,
		enemies = {
			{2300, windowH-groundH-80, 3}
		}
	},
	-- Room 2
	{
		w = 2000,
		enemies = {
			{1500, windowH-groundH-80, 2}
		}
	}
}

map = {
	currentRoom = rooms[1],
	currentRoomID = 1,
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
	end,
	progressRoom = function()
		map.currentRoomID = map.currentRoomID + 1
		map.currentRoom = rooms[map.currentRoomID]
		map.loadRoom()
	end,
	load = function()
		map.loadRoom()
	end,
	update = function()
		if map.currentRoomID < #rooms and player.x >= roomW-player.w-1 then
			map.progressRoom()
		end
	end
}

return map