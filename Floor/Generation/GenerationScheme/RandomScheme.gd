class_name RandomScheme extends GenerationScheme

const WALKABLETILE = preload("res://Floor/Domain/Tile/Walkable.tscn")
const EMPTYTILE = preload("res://Floor/Domain/Tile/Empty.tscn")
const UNWALKABLETILE = preload("res://Floor/Domain/Tile/Unwalkable.tscn")
const MONSTER = preload("res://Entity/Mob/Domain/Monster.tscn")

var border:bool = true;

func GenerateState(floor:Floor) -> State:
	
	if(border):
		for x in range(0, self.state.dim.x):
			self.state.setTile(Vector2(x, 0), UNWALKABLETILE.instantiate().init(floor.WALL_TEXTURE, Vector2(x, 0)));
			self.state.setTile(Vector2(x, self.state.dim.y-1), UNWALKABLETILE.instantiate().init(floor.WALL_TEXTURE, Vector2(x, self.state.dim.y-1)));
		for y in range(0, self.state.dim.y):
			self.state.setTile(Vector2(0, y), UNWALKABLETILE.instantiate().init(floor.WALL_TEXTURE, Vector2(0, y)));
			self.state.setTile(Vector2(self.state.dim.x-1, y), UNWALKABLETILE.instantiate().init(floor.WALL_TEXTURE, Vector2(self.state.dim.x-1, y)));
	
	for x in self.state.dim.x:
		for y in self.state.dim.y:
			if(randi_range(1,2) == 1 && self.state.getTile(Vector2(x,y)).TYPE == Tile.TileType.EMPTY):
				var walkableTile = WALKABLETILE.instantiate().init(floor.BASIC_FLOOR_TEXTURE, Vector2(x,y));
				if(randi_range(1,10) == 10):
					self.debug("RandomeScheme.GenerateState | added Monster", {"pos": Vector2(x,y)})
					self.state.addMob(MONSTER.instantiate().init(Vector2(x,y), self.state));
				self.state.setTile(Vector2(x,y), walkableTile);
				
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
			self.debug("RandomScheme.GenerateState | Tried to place player, failed", {"attemptPos": tile.pos})
	
	return self.state;
