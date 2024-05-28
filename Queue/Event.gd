class_name Event extends GameObject

var origin:Entity;
var target:Entity;

var type:EventType = EventType.NULL;

enum EventType{
	NULL,
	MOVEMENT,
	WAIT
}

func execute()->void:
	self.warning("Event.execute | Attempted to exec base event", {});
