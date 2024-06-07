class_name DamageEffect extends BouncingText

const MAX_X_FORCE = 40;
const MIN_X_FORCE = 10;

const MAX_Y_FORCE = -50;
const MIN_Y_FORCE = -100;

func make(dmg:int, pos:Vector2)->DamageEffect:
	var text:Label = self.createLabel(dmg);
	
	self.init(
		pos, 
		Vector2(
			randf_range(self.MIN_X_FORCE, self.MAX_X_FORCE) * self.leftOrRight(), 
			randf_range(self.MIN_Y_FORCE, self.MAX_Y_FORCE)
		), 
		randi_range(250,350), 
		text
	)
	
	return self;

func leftOrRight()->int:
	return (1 if randi_range(0, 1) == 1 else -1);

func createLabel(dmg:int)->Label:
	var text:Label = Label.new();
	text.text = "%d" % dmg;
	var settings = LabelSettings.new();
	settings.font_color = Color.RED;
	settings.font_size = 25;
	text.label_settings = settings;
	return text;
	
func getClassName()->String:
	return "DamageEffect"
