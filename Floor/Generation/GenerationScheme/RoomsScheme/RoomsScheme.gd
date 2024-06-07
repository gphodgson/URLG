class_name RoomsScheme extends GenerationScheme

const WALKABLETILE = preload("res://Floor/Domain/Tile/Walkable.tscn")
const EMPTYTILE = preload("res://Floor/Domain/Tile/Empty.tscn")
const UNWALKABLETILE = preload("res://Floor/Domain/Tile/Unwalkable.tscn")
const MONSTER = preload("res://Entity/Mob/Domain/Monster.tscn")

const ROOM_COUNT = 10;
const ROOM_SIZE_MAX = 10;
const ROOM_SIZE_MIN = 3;
const TOTAL_MOBS = 100;

var mobCount:int = 0;

func makeHallway(floor:Floor, room:Room, nearestRoom:Room):
	var cornerPoint:Vector2 = Vector2.ZERO;
	var targetRoom:Vector2 = Vector2.ZERO;
	var targetNearestRoom:Vector2 = Vector2.ZERO;
	
	if(room.pos.x > nearestRoom.pos.x && room.pos.y < nearestRoom.pos.y): #SW
		targetRoom = Vector2(randi_range(room.pos.x, room.pos.x + (room.size.x-1)), room.pos.y + (room.size.y-1));
		targetNearestRoom = Vector2(nearestRoom.pos.x+nearestRoom.size.x-1, randi_range(nearestRoom.pos.y, nearestRoom.pos.y+nearestRoom.size.y-1));
		cornerPoint = Vector2(targetRoom.x, targetNearestRoom.y);
		#self.state.setTile(targetRoom, WALKABLETILE.instantiate().init(floor.BLUE_TEXTURE, targetRoom));
		#self.state.setTile(targetNearestRoom, WALKABLETILE.instantiate().init(floor.RED_TEXTURE, targetNearestRoom));
		#self.state.setTile(cornerPoint, WALKABLETILE.instantiate().init(floor.PURPLE_TEXTURE, cornerPoint));
		#self.debug("RoomsScheme.Generate | Placed points!", {"targetRoom":targetRoom, "targetNearestRoom": targetNearestRoom, "cornerPoint":cornerPoint})
		self.drawHall(floor,targetNearestRoom,targetRoom,cornerPoint);
		
	elif(room.pos.x < nearestRoom.pos.x && room.pos.y < nearestRoom.pos.y): #SE
		targetRoom = Vector2(randi_range(room.pos.x, room.pos.x + (room.size.x-1)), room.pos.y + (room.size.y-1));
		targetNearestRoom = Vector2(randi_range(nearestRoom.pos.x, nearestRoom.pos.x+nearestRoom.size.x-1), nearestRoom.pos.y+nearestRoom.size.y-1);
		cornerPoint = Vector2(targetRoom.x, targetNearestRoom.y);
		#self.state.setTile(targetRoom, WALKABLETILE.instantiate().init(floor.BLUE_TEXTURE, targetRoom));
		#self.state.setTile(targetNearestRoom, WALKABLETILE.instantiate().init(floor.RED_TEXTURE, targetNearestRoom));
		#self.state.setTile(cornerPoint, WALKABLETILE.instantiate().init(floor.PURPLE_TEXTURE, cornerPoint));
		#self.debug("RoomsScheme.Generate | Placed points!", {"targetRoom":targetRoom, "targetNearestRoom": targetNearestRoom, "cornerPoint":cornerPoint})
		self.drawHall(floor,targetNearestRoom,targetRoom,cornerPoint);
		
	elif(room.pos.x > nearestRoom.pos.x && room.pos.y > nearestRoom.pos.y): #NE
		targetNearestRoom = Vector2(randi_range(room.pos.x, room.pos.x + (room.size.x-1)), room.pos.y + (room.size.y-1));
		targetRoom = Vector2(randi_range(nearestRoom.pos.x, nearestRoom.pos.x+nearestRoom.size.x-1), nearestRoom.pos.y+nearestRoom.size.y-1);
		cornerPoint = Vector2(targetRoom.x, targetNearestRoom.y);
		#self.state.setTile(targetRoom, WALKABLETILE.instantiate().init(floor.BLUE_TEXTURE, targetRoom));
		#self.state.setTile(targetNearestRoom, WALKABLETILE.instantiate().init(floor.RED_TEXTURE, targetNearestRoom));
		#self.state.setTile(cornerPoint, WALKABLETILE.instantiate().init(floor.PURPLE_TEXTURE, cornerPoint));
		#self.debug("RoomsScheme.Generate | Placed points!", {"targetRoom":targetRoom, "targetNearestRoom": targetNearestRoom, "cornerPoint":cornerPoint})
		self.drawHall(floor,targetNearestRoom,targetRoom,cornerPoint);

func drawHall(floor:Floor, targetX:Vector2, targetY:Vector2, cornerPoint:Vector2):
	self.state.setTile(cornerPoint, WALKABLETILE.instantiate().init(floor.BLUE_TEXTURE, cornerPoint));
	for i in range(1, cornerPoint.distance_to(targetX)):
		var tilePos:Vector2 = Vector2(0, cornerPoint.y);
		if(targetX.x <= cornerPoint.x):
			tilePos.x = cornerPoint.x - i;
		else:
			tilePos.x = cornerPoint.x + i;
		self.state.setTile(tilePos, WALKABLETILE.instantiate().init(floor.RED_TEXTURE, tilePos));
	
	for i in range(1, cornerPoint.distance_to(targetY)):
		var tilePos:Vector2 = Vector2(cornerPoint.x, 0);
		if(targetY.y <= cornerPoint.y):
			tilePos.y = cornerPoint.y - i;
		else:
			tilePos.y = cornerPoint.y + i;
		self.state.setTile(tilePos, WALKABLETILE.instantiate().init(floor.PURPLE_TEXTURE, tilePos));
		
		
		
func GenerateState(floor:Floor) -> State:
	var rooms:Array[Room] = [];
	
	for i in range(self.ROOM_COUNT):
		var roomSize:Vector2 = Vector2(randi_range(self.ROOM_SIZE_MIN,self.ROOM_SIZE_MAX), randi_range(self.ROOM_SIZE_MIN,self.ROOM_SIZE_MAX));
		var roomPos:Vector2 = Vector2(randi_range(self.state.dim.x-1, 1), randi_range(1, self.state.dim.y-1));
	
		if(roomPos.x + roomSize.x > self.state.dim.x):
			roomPos.x -= roomSize.x;
		if(roomPos.y + roomSize.y > self.state.dim.y):
			roomPos.y -= roomSize.y;
		
		rooms.append(Room.new().init(i, roomSize, roomPos));
		for x in range(roomSize.x):
			for y in range(roomSize.y):
				var tilePos:Vector2 = Vector2(roomPos.x+x, roomPos.y+y);
				self.state.setTile(tilePos, WALKABLETILE.instantiate().init(floor.BASIC_FLOOR_TEXTURE, tilePos));
				if(randi_range(1,20) == 10):
					#self.debug("RandomeScheme.GenerateState | added Monster", {"pos": tilePos})
					if(self.mobCount < TOTAL_MOBS):
						self.state.addMob(MONSTER.instantiate().init(tilePos, self.state));
						self.mobCount = self.mobCount + 1
	
	#self.makeHallway(floor, room, nearestRoom)
	var keepHalling = true;
	var room:Room = rooms[0];
	room.nowPathed();
	
	while(keepHalling):
		var nearestRoom:Room;
		while(nearestRoom == null):
			var index:int = randi_range(0, rooms.size()-1)
			var testRoom:Room = rooms[index];
			
			if(!testRoom.pathed):
				nearestRoom = testRoom;
		
		self.makeHallway(floor, room, nearestRoom);
		nearestRoom.nowPathed();
		room = nearestRoom;
		keepHalling = false;
		
		for testRoom in rooms:
			if testRoom.pathed == false:
				keepHalling = true;
	
	for x in self.state.dim.x:
		for y in self.state.dim.y:
			var tile:Tile = self.state.getTile(Vector2(x,y));
			if(tile.TYPE == Tile.TileType.WALKABLE):
				var wallTiles = [
					self.state.getTile(tile.pos + Vector2(0,1)), #bottom tile
					self.state.getTile(tile.pos + Vector2(0,-1)), #top tile
					self.state.getTile(tile.pos + Vector2(1,0)), #right tile
					self.state.getTile(tile.pos + Vector2(-1,0)) #left tile
				];
				
				for walltile in wallTiles:
					if(walltile != null && walltile.TYPE == Tile.TileType.EMPTY):
						var unwalkableTile = UNWALKABLETILE.instantiate().init(floor.WALL_TEXTURE, walltile.pos);
						self.state.setTile(walltile.pos, unwalkableTile)
		
	var cycle:bool = true;
	
	while(cycle):
		var x:int = randi_range(0, Floor.FLOOR_MAX_WIDTH-1);
		var y:int = randi_range(0, Floor.FLOOR_MAX_HEIGHT-1);
		var tile = self.state.getTile(Vector2(x,y));
		
		if(tile.TYPE == Tile.TileType.WALKABLE):
			self.state.player.setPos(tile.pos);
			cycle = false;
		else:
			#self.debug("RoomsScheme.GenerateState | Tried to place player, failed", {"attemptPos": tile.pos})
			pass;
	
	return self.state;
