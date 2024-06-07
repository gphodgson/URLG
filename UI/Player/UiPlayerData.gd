class_name UiPlayerData extends UiElement

var trackingPlayer:PlayerData;

@onready var hpLabel:Label = get_node("hp");

func init(playerData:PlayerData)->UiPlayerData:
	self.trackingPlayer = playerData;
	return self;

func _process(delta):
	self.hpLabel.text = "HP: %d" % trackingPlayer.hp;
