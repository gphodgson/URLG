class_name KillEvent extends Event

func init(target:Entity) -> KillEvent:
	self.type = EventType.KILL;
	self.target = target;
	return self;

func execute():
	self.target.kill();
