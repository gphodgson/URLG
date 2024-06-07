class_name Player extends Entity

const IDLE_TEXTURE = preload("res://Sprites/Player.png");
const DIRECTION = preload("res://Sprites/Direction.png");
const TARGET_TEXTURE = preload("res://Sprites/target.png");

const MAX_ZOOM_IN = Vector2(3,3);
const MAX_ZOOM_OUT = Vector2(1,1);

enum Direction{
	NORTH,SOUTH,EAST,WEST
}

var data:PlayerData;
var zoom:Vector2 = Vector2(2,2);
var directionTexture:Resource = TARGET_TEXTURE;
var facing:Direction = self.Direction.SOUTH;

@onready var camera:Camera2D = get_node("Camera2D");
@onready var dirSprite:Sprite2D = get_node("DirSprite");

func init(_pos:Vector2)->Player:
	self.setPos(_pos);
	self.texture = IDLE_TEXTURE;
	self.data = PlayerData.new().initDefault();
	return self;

func changeDirection(dir:Direction)->void:
	self.facing = dir;
	self.updateSpriteTexture();

func cloneFromPlayer(newPlayer:Player):
	self.cloneFromEntity(newPlayer);
	self.data = newPlayer.data;
	
func updateSpriteTexture()->void:
	super();
	self.dirSprite.texture = self.directionTexture;
	if self.facing == Direction.SOUTH:
		self.dirSprite.position = Vector2(0, self.DEFAULT_ENTITY_SIZE.y);
	elif self.facing == Direction.EAST:
		self.dirSprite.position = Vector2(self.DEFAULT_ENTITY_SIZE.x, 0);
	elif self.facing == Direction.WEST:
		self.dirSprite.position = Vector2(-self.DEFAULT_ENTITY_SIZE.y, 0);
	elif self.facing == Direction.NORTH:
		self.dirSprite.position = Vector2(0, -self.DEFAULT_ENTITY_SIZE.y);

func getTarget(state:State)->Entity:
	if self.facing == Direction.NORTH:
		return state.getEntityOnTile(self.pos + Vector2(0,-1));
	elif self.facing == Direction.SOUTH:
		return state.getEntityOnTile(self.pos + Vector2(0,1));
	elif self.facing == Direction.EAST:
		return state.getEntityOnTile(self.pos + Vector2(1,0));
	elif self.facing == Direction.WEST:
		return state.getEntityOnTile(self.pos + Vector2(-1,0));
	
	return null;
	
func _ready():
	self.updateSpriteTexture();
	self.camera.zoom = self.zoom;



func _input(event):
	if event.is_action_pressed("rotate_north"):
		self.changeDirection(Direction.NORTH);
	if event.is_action_pressed("rotate_south"):
		self.changeDirection(Direction.SOUTH);
	if event.is_action_pressed("rotate_east"):
		self.changeDirection(Direction.EAST);
	if event.is_action_pressed("rotate_west"):
		self.changeDirection(Direction.WEST);
	
	if event.is_action_pressed("zoom_in"):
		self.zoom += Vector2(0.1,0.1);
		if(self.zoom >= MAX_ZOOM_IN):
			self.zoom = MAX_ZOOM_IN
		self.camera.zoom = self.zoom;
	if event.is_action_pressed("zoom_out"):
		self.zoom += Vector2(-0.1,-0.1);
		if(self.zoom <= MAX_ZOOM_OUT):
			self.zoom = MAX_ZOOM_OUT
		self.camera.zoom = self.zoom;
