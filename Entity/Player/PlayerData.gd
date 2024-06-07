class_name PlayerData extends GameObject

var hp:int;
var level:int;
var xp:int;

var dmg:int;


func initDefault()->PlayerData:
	self.hp = 100;
	self.level = 1;
	self.xp = 0;
	self.dmg = 5;
	
	return self;


func initDetail(
	_hp:int,
	_level:int,
	_xp:int,
	_dmg:int
) -> PlayerData:
	self.hp = _hp;
	self.level = _level;
	self.xp = _xp;
	self.dmg = _dmg;
	
	return self;
