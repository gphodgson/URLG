class_name Player extends Entity

const IDLE_TEXTURE = preload("res://Sprites/Player.png");

var data:PlayerData;

func init(_pos:Vector2)->Player:
	self.setPos(_pos);
	self.texture = IDLE_TEXTURE;
	self.data = PlayerData.new().initDefault();
	return self

func cloneFromPlayer(newPlayer:Player):
	self.cloneFromEntity(newPlayer);
	self.data = newPlayer.data;
	
func _ready():
	self.updateSpriteTexture();

