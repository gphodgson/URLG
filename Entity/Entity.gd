class_name Entity extends GameObject

const DEFAULT_ENTITY_SIZE = Vector2(50,50);
const TEXTEFFECT = preload("res://Effect/Domain/ModalEffect.tscn");

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

func kill():
	self.queue_free();
	
func onInteraction():
	self.warning("onInteraction | Interacted with base Entity class!!", {"message": "Hi Player!!"})

func modal(message:String):
	self.debug("modal | Mob has a message for you!", {"message": message, "pos":self.position})
	#var cool:DamageEffect = TEXTEFFECT.instantiate().make(randi_range(1,10), Vector2.ZERO)
	#cool.startEffect();
	var text:Label = Label.new();
	text.text = message;
	var settings = LabelSettings.new();
	settings.font_color = Color.WHITE;
	settings.font_size = 25;
	text.label_settings = settings;
	var modalEffect:ModalEffect = TEXTEFFECT.instantiate().init(Vector2.ZERO, text , 500);
	modalEffect.startEffect();
	add_child(modalEffect);

func cloneFromEntity(newEntity:Entity)->void:
	self.setPos(newEntity.pos);
	self.texture = newEntity.texture;
	self.traits = newEntity.traits;
	self.updateSpriteTexture();

func getClassName()->String:
	return "Entity"
