class_name RandomBrain extends Brain

var state:State;

func init(state:State)->RandomBrain:
	self.state = state;
	
	return self;
	
func getNextEvent(origin:Entity)->Event:
	if(randi_range(0,1) == 0):
		var movement:Vector2 = Vector2(randi_range(-1,1), randi_range(-1,1));
		if(self.state.isMovementValid(origin.pos + movement, origin)):
			return MovementEvent.new().init(origin, movement);
		else:
			return WaitEvent.new().init();
	else:
		return WaitEvent.new().init();
