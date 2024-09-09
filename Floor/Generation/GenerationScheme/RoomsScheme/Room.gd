class_name Room extends GameObject

var id:int;
var size:Vector2;
var pos:Vector2;
var pathed:bool = false;
var connections:Array[int] = [];


func nowPathed()->void:
	self.pathed = true;

func init(id:int, size:Vector2, pos:Vector2)->Room:
	self.id = id;
	self.size = size;
	self.pos = pos;
	
	return self;
