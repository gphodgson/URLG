class_name Effect extends GameObject

var start:bool = false;

func getClassName()->String:
	return "Effect"

func startEffect():
	self.start = true;
	
func kill():
	queue_free();
