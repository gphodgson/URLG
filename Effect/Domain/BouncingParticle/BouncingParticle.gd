class_name BouncingParticle extends Effect

var vel:Vector2 = Vector2.ZERO
var lifetime:int;

const GRAV_POWER:Vector2 = Vector2(0, 75);

func create(pos:Vector2, initialVel:Vector2, lifetime:int):
	position = pos;
	self.vel = initialVel
	self.lifetime = lifetime;
	
func _process(delta):
	if(self.start):
		position = position + (self.vel * delta);
		self.vel = self.vel + (self.GRAV_POWER * delta);
		
		self.lifetime = self.lifetime - 1
		
		if(self.lifetime <= 0):
			self.kill();

func getClassName()->String:
	return "BouncingParticle"
