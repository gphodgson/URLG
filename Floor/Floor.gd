class_name Floor extends GameObject

const FLOOR_MAX_WIDTH = 5;
const FLOOR_MAX_HEIGHT = 5;

var TYPE:FloorType = FloorType.NULL;
var BASIC_FLOOR_TEXTURE:Texture2D = load("res://Sprites/Floor.png");

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
	return self;
