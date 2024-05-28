class_name Brain extends GameObject

enum BrainType {
	NULL,
	RANDOM
}

var type:BrainType = BrainType.NULL;

func getNextEvent(origin:Entity)->Event:
	return WaitEvent.new().init();
