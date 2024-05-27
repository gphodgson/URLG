class_name GenerationScheme extends GameObject

var state:State;

func init() -> GenerationScheme:
	self.state = State.new().init();
	return self

func GenerateState(floor:Floor) -> State:
	return self.state;
