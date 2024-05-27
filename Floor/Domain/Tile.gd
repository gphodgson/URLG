class_name Tile extends GameObject

var TYPE:TileType = TileType.NULL;
var texture:Texture2D;
var pos:Vector2 = Vector2.ZERO;

@onready var sprite:Sprite2D = get_node('Sprite');

enum TileType{
	NULL,
	EMPTY,
	WALKABLE,
	UNWALKABLE,
	WALL
}

func init(_texture:Resource, _pos:Vector2)->Tile:
	self.initConsts();
	self.texture = _texture;
	self.pos = _pos;
	self.snapPosToScreenPos();
	return self;
	
func changeToTile(tile:Tile):
	self.TYPE = tile.TYPE;
	self.texture = tile.texture;
	self.updateSpriteTexture();
	
func updateSpriteTexture()->void:
	if(sprite != null):
		sprite.texture = self.texture;
	
func initConsts()->void:
	TYPE = TileType.NULL;
	
func _ready():
	self.updateSpriteTexture();
