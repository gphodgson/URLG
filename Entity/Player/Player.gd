class_name Player extends Entity

const IDLE_TEXTURE = preload("res://Sprites/Player.png");

const MAX_ZOOM_IN = Vector2(3,3);
const MAX_ZOOM_OUT = Vector2(1,1);

var data:PlayerData;
var zoom:Vector2 = Vector2(2,2);

@onready var camera:Camera2D = get_node("Camera2D");

func init(_pos:Vector2)->Player:
	self.setPos(_pos);
	self.texture = IDLE_TEXTURE;
	self.data = PlayerData.new().initDefault();
	return self;

func cloneFromPlayer(newPlayer:Player):
	self.cloneFromEntity(newPlayer);
	self.data = newPlayer.data;
	
func _ready():
	self.updateSpriteTexture();
	self.camera.zoom = self.zoom;

func _input(event):
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
