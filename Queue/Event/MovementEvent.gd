class_name MovementEvent extends Event

var amount:Vector2;

func init(_origin:Entity, _amount:Vector2) -> MovementEvent:
	self.origin = _origin;
	self.target = null;
	self.amount = _amount;
	
	self.type = EventType.MOVEMENT;
	
	return self;

func execute():
	self.origin.move(amount);
