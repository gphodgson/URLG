class_name WaitEvent extends Event

func init() -> WaitEvent:
	self.type = EventType.WAIT;
	return self;

func execute():
	pass;
