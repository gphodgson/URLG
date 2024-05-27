extends Node

const FLOOR = preload("res://Floor/Floor.tscn");

func _ready():
	randomize();
	var debugFloor:Floor = FLOOR.instantiate().init();
	var randomGen = RandomScheme.new().init();
	add_child(debugFloor);
	
	debugFloor.Generate(randomGen);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
