class_name Game extends GameObject

const FLOOR = preload("res://Floor/Floor.tscn");
const PLAYERDATAUI = preload("res://UI/Player/UiPlayerData.tscn")
const TEXTEFFECT = preload("res://Effect/Domain/BouncingParticle/DamageEffect.tscn");

const MOVE_LOCK_DELAY = 1.5;
const AUTO_MOVE_DELAY = 0.3;

var debugFloor:Floor;
var gameState:GameState = GameState.Play;

var uiPlayerData:UiPlayerData;

var moveLock:bool = true;
var moveLockTime:float = 0;
var autoMoveTime:float = 0;

enum GameState {
	Play,
	Modals
}

@onready var uiLayer:CanvasLayer = get_node("UILayer");

func _ready():
	randomize();
	self.debugFloor = FLOOR.instantiate().init();
	var generation = RoomsScheme.new().init();
	add_child(self.debugFloor);
	
	self.debugFloor.Generate(generation);
	
	uiPlayerData = PLAYERDATAUI.instantiate().init(self.debugFloor.state.player.data);
	uiLayer.add_child(uiPlayerData);

func step():
	if(self.gameState == self.GameState.Play):
		self.debugFloor.step();
	
func movePlayer(vector:Vector2):
	if(self.debugFloor.isMovementValid(self.debugFloor.getPlayer().pos + vector)):
		self.debugFloor.queueEvent(MovementEvent.new().init(self.debugFloor.getPlayer(), vector));
		self.step()
		
func interaction():
	self.debugFloor.interaction();

func attack():
	self.debugFloor.attack();
	
func wait():
	self.step();

func _input(event):
	if event.is_action_pressed("move_up"):
		self.movePlayer(Vector2(0,-1));
	if event.is_action_pressed("move_down"):
		self.movePlayer(Vector2(0,1));
	if event.is_action_pressed("move_right"):
		self.movePlayer(Vector2(1,0));
	if event.is_action_pressed("move_left"):
		self.movePlayer(Vector2(-1,0));
	if event.is_action_pressed("wait"):
		self.wait();
		
	if event.is_action_pressed("move_up") || event.is_action_pressed("move_down") || event.is_action_pressed("move_left") || event.is_action_pressed("move_right") || event.is_action_pressed("wait"):
		self.moveLockTime = 1;
	if event.is_action_released("move_up") || event.is_action_released("move_down") || event.is_action_released("move_left") || event.is_action_released("move_right")|| event.is_action_released("wait"):
		self.moveLock = true;
		self.moveLockTime = 0;
		self.autoMoveTime = 0;
		
	if event.is_action_pressed("interact"):
		self.interaction();
	if event.is_action_pressed("attack"):
		self.attack();
		
	if event.is_action_pressed("debug1"):
		self.debugFloor.state.player.addTrait(PhaseTrait.new().init());
	if event.is_action_pressed("debug2"):
		var genScheme = RoomsScheme.new().init();
		self.debugFloor.Generate(genScheme);
	if event.is_action_pressed("debug3"):
		var cool:DamageEffect = TEXTEFFECT.instantiate().make(randi_range(1,10),debugFloor.getPlayer().position)
		cool.startEffect();
		add_child(cool);
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(self.moveLockTime != 0):
		self.moveLockTime = self.moveLockTime + delta;
		if (self.moveLockTime >= self.MOVE_LOCK_DELAY):
			self.moveLock = false;
	
	if(!self.moveLock):
		self.autoMoveTime = self.autoMoveTime + delta;
		if(self.autoMoveTime >= self.AUTO_MOVE_DELAY):
			self.autoMoveTime = 0;
			if Input.is_action_pressed("move_up"):
				self.movePlayer(Vector2(0,-1));
			if Input.is_action_pressed("move_down"):
				self.movePlayer(Vector2(0,1));
			if Input.is_action_pressed("move_right"):
				self.movePlayer(Vector2(1,0));
			if Input.is_action_pressed("move_left"):
				self.movePlayer(Vector2(-1,0));
			if Input.is_action_pressed("wait"):
				self.wait();
		
