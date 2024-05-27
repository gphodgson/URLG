class_name Player extends GameObject

const IDLE_TEXTURE = preload("res://Sprites/Player.png");

var texture:Resource;
var pos:Vector2 = Vector2.ZERO;
var data:PlayerData;

var sprite:Sprite2D;

func init(_pos:Vector2)->Player:
	self.setPos(_pos);
	self.texture = IDLE_TEXTURE;
	self.data = PlayerData.new().initDefault();
	return self

func updateSpriteTexture()->void:
	if(sprite != null):
		sprite.texture = self.texture;
	else:
		self.warning("Player.updateSpriteTexture | Attempted Sprite Update With Null Sprite", {});

func cloneFromPlayer(newPlayer:Player):
	self.setPos(newPlayer.pos);
	self.texture = newPlayer.texture;
	self.updateSpriteTexture();
	self.data = newPlayer.data;
	
func setPos(newPos:Vector2)->void:
	self.pos = newPos;
	self.snapPosToScreenPos();
	
func move(vector:Vector2)->void:
	self.pos += vector;
	self.snapPosToScreenPos();
	
func _ready():
	self.sprite = get_node("Sprite2D");
	self.updateSpriteTexture();

