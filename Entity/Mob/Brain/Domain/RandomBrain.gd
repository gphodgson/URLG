class_name RandomBrain extends Node

func init(_state:State)->RandomBrain:
	return self;
	
func getNextEvent(origin:Entity)->Event:
	if(randi_range(0,1) == 0):
		return MovementEvent.new().init(origin, Vector2(randi_range(-1,1), randi_range(-1,1)));
	else:
		return WaitEvent.new().init();
