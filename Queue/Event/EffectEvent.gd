class_name EffectEvent extends Event

var effect:Effect;

func init(effect:Effect):
	self.effect = effect;
	
func execute():
	self.effect.startEffect();

func getClassName()->String:
	return "EffectEvent";
