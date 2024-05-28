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
	self.debugFloor.queue.execute();
	self.debugFloor.queue.clearEvents();
	
func movePlayer(vector:Vector2):
	if(self.isMovementValid(self.debugFloor.getPlayer().pos + vector)):
		self.debugFloor.queue.addEventToQueue(MovementEvent.new().init(self.debugFloor.getPlayer(), vector));
		self.step()
		
func isMovementValid(pos:Vector2)->bool:
	if(self.debugFloor.isOutOfBounds(pos)):
		return false;
	if(self.debugFloor.state.getTile(pos).TYPE == Tile.TileType.EMPTY):
		return false;
	
	return true;

func _input(event):
	if event.is_action_pressed("move_up"):
		self.debug("Game._input | Pressed move_up input", {})
		self.movePlayer(Vector2(0,-1));
	if event.is_action_pressed("move_down"):
		self.debug("Game._input | Pressed move_down input", {})
		self.movePlayer(Vector2(0,1));
	if event.is_action_pressed("move_right"):
		self.debug("Game._input | Pressed move_right input", {})
		self.movePlayer(Vector2(1,0));
	if event.is_action_pressed("move_left"):
		self.debug("Game._input | Pressed move_left input", {})
		self.movePlayer(Vector2(-1,0));
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
