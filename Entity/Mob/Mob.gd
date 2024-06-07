class_name Mob extends Entity

var type:String = "NULLMOB"
var brain:Brain;
var stats:MobStats = MobStats.new().default();

func getNextEvent()->Event:
	return self.brain.getNextEvent(self);
