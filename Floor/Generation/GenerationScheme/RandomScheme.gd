class_name RandomScheme extends GenerationScheme

const WALKABLETILE = preload("res://Floor/Domain/Tile/Walkable.tscn")
const EMPTYTILE = preload("res://Floor/Domain/Tile/Empty.tscn")
const MONSTER = preload("res://Entity/Mob/Domain/Monster.tscn")

var playerPlaced = false;

func GenerateState(floor:Floor) -> State:
	for x in self.state.dim.x:
		for y in self.state.dim.y:
			if(randi_range(1,2) == 1):
				var walkableTile = WALKABLETILE.instantiate().init(floor.BASIC_FLOOR_TEXTURE, Vector2(x,y));
				if(randi_range(1,10) == 10):
					self.debug("RandomeScheme.GenerateState | added Monster", {"pos": Vector2(x,y)})
					self.state.addMob(MONSTER.instantiate().init(Vector2(x,y), self.state));
				self.state.setTile(Vector2(x,y), walkableTile);
			else:
				var emptyTile = EMPTYTILE.instantiate().init(floor.EMPTY_TEXTURE, Vector2(x,y));
				self.state.setTile(Vector2(x,y), emptyTile);
				
	var cycle:bool = true;
	
	while(cycle):
		var x:int = randi_range(0, Floor.FLOOR_MAX_WIDTH-1);
		var y:int = randi_range(0, Floor.FLOOR_MAX_HEIGHT-1);
		var tile = self.state.getTile(Vector2(x,y));
		
		if(tile.TYPE != Tile.TileType.EMPTY):
			self.state.player.setPos(tile.pos);
			cycle = false;
		else:
			self.debug("RandomScheme.GenerateState | Tried to place player, failed", {"attemptPos": tile.pos})
		
	return self.state;
