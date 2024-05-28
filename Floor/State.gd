class_name State extends GameObject

var state:Array = [];
var mobs:Array[Mob] = [];
var player:Player;
var dim:Vector2 = Vector2.ZERO;

var PLAYER_NODE = load("res://Entity/Player/Player.tscn")

func init() -> State:
	self.FillEmpty();
	self.initalizeDimensions();
	self.player = PLAYER_NODE.instantiate().init(Vector2.ZERO);
	return self;

func isMovementValid(pos:Vector2, origin:Entity)->bool:
	if(self.isOutOfBounds(pos)):
		return false;
	if(self.getTile(pos).TYPE != Tile.TileType.WALKABLE):
		if(origin.hasTrait("PHASE_TRAIT")):
			return true;
		return false;
	
	return true;

func isOutOfBounds(pos:Vector2)->bool:
	return pos.x < 0 || \
		pos.x >= self.dim.x || \
		pos.y < 0 || \
		pos.y >= self.dim.y;

func UpdateTileState(newState:State) -> void:
	if(newState.dim != self.dim):
		self.fatal("UpdateTileState | Invalid newState Dimensions", {"stateDim": self.dim, "newStateDim": newState.dim});
		return;

	for x in range(newState.state.size()):
		for y in range(newState.state[x].size()):
			self.setTile(Vector2(x,y), newState.getTile(Vector2(x,y)))
	
	self.mobs = newState.mobs;
	self.setPlayer(newState.player);

func getTile(pos:Vector2) -> Tile:
	if(pos.x >= self.dim.x || pos.y >= self.dim.y || pos.x < 0 || pos.y < 0):
		self.fatal("getTile | Invalid pos provided.", {"pos": pos, "dim": self.dim})
		return;
	return self.state[pos.x][pos.y];

func setTile(pos:Vector2, newTile:Tile) -> void:
	if(pos.x > self.dim.x || pos.y > self.dim.y):
		self.fatal("setTile | Invalid pos provided.", {"pos": pos, "dim": self.dim})
		return;
	self.getTile(pos).changeToTile(newTile);

func setPlayer(newPlayer:Player)->void:
	self.player.cloneFromPlayer(newPlayer);

func addMob(mob:Mob)->void:
	self.mobs.append(mob);

func initalizeDimensions() -> void:
	var y = self.state.size();
	var x = 0;
	for row in self.state:
		if(row.size() > x):
			x = row.size();
	
	self.dim = Vector2(x,y);

func FillEmpty() -> void:
	for i in range(Floor.FLOOR_MAX_WIDTH):
		self.state.append([]);
		for j in range(Floor.FLOOR_MAX_HEIGHT):
			var tile = Floor.EMPTY_CELL.instantiate().init(Floor.EMPTY_TEXTURE, Vector2(i,j))
			state[i].append(tile);
	
