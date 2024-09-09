class_name BouncingText extends BouncingParticle

var text:Label;

func init(pos:Vector2, initialVel:Vector2, lifetime:int, text:Label)->BouncingText:
	self.text = text;
	self.add_child(text);
	self.create(pos, initialVel, lifetime);
	return self;

func getClassName()->String:
	return "BouncingText";
