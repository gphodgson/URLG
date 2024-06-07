class_name Queue extends GameObject

var events:Array[Event] = [];

func init()-> Queue:
	self.debug("init | Created empty queue", {});
	return self;
	
func execute():
	for event in self.events:
		event.execute();

func addEventToQueue(event:Event)->void:
	events.append(event);

func clearEvents()->void:
	events = [];

func getClassName()->String:
	return "Queue"
