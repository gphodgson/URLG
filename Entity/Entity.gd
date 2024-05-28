class_name Entity extends GameObject

var texture:Resource;
var pos:Vector2 = Vector2.ZERO;
var traits:Array[Trait] = [];

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

func addTrait(xtrait:Trait):
	self.traits.append(xtrait);
	
func hasTrait(traitName:String)->bool:
	for entityTrait in self.traits:
		if(entityTrait.getName() == traitName):
			return true;
	
	return false;

func cloneFromEntity(newEntity:Entity)->void:
	self.setPos(newEntity.pos);
	self.texture = newEntity.texture;
	self.traits = newEntity.traits;
	self.updateSpriteTexture();
	
