class_name ModalEffect extends Effect

const FADE_SPEED = 0.01;

var lifetime:int;
var text:Label;
var faded:bool=false;

func init(pos:Vector2, text:Label, lifetime:int)->ModalEffect:
	self.lifetime = lifetime;
	self.text = text;
	self.text.label_settings.font_color.a = 0;
	self.position = pos;
	self.add_child(self.text);
	return self;

func _process(delta):
	if self.start:
		if(self.faded):
			self.lifetime = self.lifetime - delta;
		else:
			self.text.label_settings.font_color.a = self.text.label_settings.font_color.a + self.FADE_SPEED;
			if(self.text.label_settings.font_color.a >= 1):
				self.faded = true;
		
		if(self.lifetime <= 0):
			self.text.label_settings.font_color.a = self.text.label_settings.font_color.a - self.FADE_SPEED;
			if(self.text.label_settings.font_color.a <= 0):
				self.kill();
