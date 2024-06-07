class_name MobStats extends GameObject

var hp:int;
var dmg:int;

func default()->MobStats:
	self.hp = 1;
	self.dmg = 0;
	return self;
	
func init(
	hp:int,
	dmg:int
)->MobStats:
	self.hp = hp;
	self.dmg = dmg;
	return self;
