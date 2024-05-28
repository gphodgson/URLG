class_name Game extends GameObject

const FLOOR = preload("res://Floor/Floor.tscn");
var debugFloor:Floor;

func _ready():
	randomize();
	self.debugFloor = FLOOR.instantiate().init();
	var randomGen = RandomScheme.new().init();
	add_child(debugFloor);
	
	debugFloor.Generate(randomGen);

func step():
	self.debugFloor.step();
	
func movePlayer(vector:Vector2):
	if(self.debugFloor.isMovementValid(self.debugFloor.getPlayer().pos + vector)):
		self.debugFloor.queueEvent(MovementEvent.new().init(self.debugFloor.getPlayer(), vector));
		self.step()
		
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
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
