class_name Entity extends GameObject

var texture:Resource;
var pos:Vector2 = Vector2.ZERO;

@onready var sprite:Sprite2D = get_node("Sprite");

func updateSpriteTexture()->void:
	if(sprite != null):
		sprite.texture = self.texture;
	else:
		self.warning("Entity.updateSpriteTexture | Attempted Sprite Update With Null Sprite", {});

func setPos(newPos:Vector2)->void:
	self.pos = newPos;
	self.snapPosToScreenPos();
	
func move(vector:Vector2)->void:
	self.pos += vector;
	self.snapPosToScreenPos();

func cloneFromEntity(newEntity:Entity)->void:
	self.setPos(newEntity.pos);
	self.texture = newEntity.texture;
	self.updateSpriteTexture();
