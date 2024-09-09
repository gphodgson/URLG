class_name Floor extends GameObject

const FLOOR_MAX_WIDTH = 50;
const FLOOR_MAX_HEIGHT = 50;

var TYPE:FloorType = FloorType.NULL;
var BASIC_FLOOR_TEXTURE:Texture2D = load("res://Sprites/Floor.png");
var WALL_TEXTURE:Texture2D = load("res://Sprites/Wall.png");
var BLUE_TEXTURE:Texture2D = load("res://Sprites/Blue.png");
var RED_TEXTURE:Texture2D = load("res://Sprites/Red.png");
var GREEN_TEXTURE:Texture2D = load("res://Sprites/Green.png");
var PURPLE_TEXTURE:Texture2D = load("res://Sprites/Purple.png");

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
	self.addMobChilds();

func queueEvent(event:Event)->void:
	self.queue.addEventToQueue(event);

func isMovementValid(pos:Vector2)->bool:
	return self.state.isMovementValid(pos, self.state.player);

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

func addMobChilds()->void:
	for mob in self.state.mobs:
		add_child(mob);

func queueMobEvents():
	for mob in self.state.mobs:
		self.queueEvent(mob.getNextEvent());

func interaction():
	var target:Entity = self.state.player.getTarget(self.state);
	if target != null:
		target.onInteraction();

func attack():
	var target:Entity = self.state.player.getTarget(self.state);
	if target != null:
		self.queue.addEventToQueue(KillEvent.new().init(target));
		get_parent().step();
		

func step():
	self.queueMobEvents();
	
	self.queue.execute();
	self.queue.clearEvents();
	self.state.removeFreedMobs();

func init()->Floor:
	self.loadConsts();
	self.state = State.new().init();
	self.initStateChildren();
	self.queue = Queue.new().init();
	return self;
