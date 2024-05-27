class_name GameObject extends Node2D

const STD_SIZE = Vector2(50,50);

func fatal(message:String, context:Dictionary):
	self.alert("FATAL", message, context);

func warning(message:String, context:Dictionary):
	self.alert("WARNING", message, context);
	
func debug(message:String, context:Dictionary):
	if(OS.is_debug_build()):
		self.alert("DEBUG", message, context);

func snapPosToScreenPos()->void:
	position = Vector2((self.pos.x * STD_SIZE.x) + (STD_SIZE.x / 2), (self.pos.y * STD_SIZE.y) + (STD_SIZE.y / 2));

func alert(
	severity:String,
	message:String,
	context:Dictionary
) -> void:
	print("------------------------------------------");
	print("ALERT: %s | Class: %s -- URLG -- !!" % [severity, get_class()]);
	print(message)
	print(context)
	print("------------------------------------------");
