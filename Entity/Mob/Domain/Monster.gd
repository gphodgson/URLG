class_name Monster extends Mob

const IDLE_TEXTURE = preload("res://Sprites/Enemy.png");

func init(startingPos:Vector2, state:State)->Monster:
	self.setPos(startingPos);
	self.texture = IDLE_TEXTURE;
	self.brain = RandomBrain.new().init(state);
	
	return self;

func _ready():
	self.updateSpriteTexture();
