class_name Mob extends Entity

var type:String = "NULLMOB"
var brain:Brain;

func getNextEvent()->Event:
	return self.brain.getNextEvent(self);
