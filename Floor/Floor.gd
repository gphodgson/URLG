class_name Floor extends GameObject

const FLOOR_MAX_WIDTH = 15;
const FLOOR_MAX_HEIGHT = 15;

var TYPE:FloorType = FloorType.NULL;
var BASIC_FLOOR_TEXTURE:Texture2D = load("res://Sprites/Floor.png");

var queue:Queue;

const EMPTY_CELL = preload("res://Floor/Domain/Tile/Empty.tscn");
const EMPTY_TEXTURE:Resource = preload("res://Sprites/Empty.png");

enum FloorType{
	NULL,
	DUNGEON
}

var state:State;

func Generate(generationScheme: GenerationScheme)->void:
	var newState:State = generationScheme.GenerateState(self);
	self.state.UpdateTileState(newState);

func isOutOfBounds(pos:Vector2)->bool:
	return pos.x < 0 || \
		pos.x >= self.FLOOR_MAX_WIDTH || \
		pos.y < 0 || \
		pos.y >= self.FLOOR_MAX_HEIGHT;

func getPlayer()->Player:
	return self.state.player;

func loadConsts() -> void:
	TYPE = FloorType.NULL;
	BASIC_FLOOR_TEXTURE = load("res://Sprites/Floor.png");

func initStateChildren() -> void:
	for x in range(self.state.dim.x):
		for tile in self.state.state[x]:
			add_child(tile);
	add_child(self.state.player);

func init()->Floor:
	self.loadConsts();
	self.state = State.new().init();
	self.initStateChildren();
	self.queue = Queue.new().init();
	return self;
