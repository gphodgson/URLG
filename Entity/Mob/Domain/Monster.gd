class_name Monster extends Mob

const IDLE_TEXTURE = preload("res://Sprites/Enemy.png");

func init(startingPos:Vector2, state:State)->Monster:
	self.setPos(startingPos);
	self.texture = IDLE_TEXTURE;
	self.brain = RandomBrain.new().init(state);
	
	self.stats = MobStats.new().init(
		10,
		1	
	);
	
	return self;

func onInteraction():
	self.modal("RAWR Xd");

func getClassName()->String:
	return "Monster"

func _ready():
	self.updateSpriteTexture();
