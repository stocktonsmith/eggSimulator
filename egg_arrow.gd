extends AnimatedSprite2D

var current_mouse_position;
var egg_body;

const ARROW_GROW_RATE = .5;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	egg_body = get_node("../EggPhysicsBody");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = egg_body.position;
	current_mouse_position = get_global_mouse_position();
	rotation = (current_mouse_position - position).normalized().angle() + PI / 2;
	if visible:
		scale.y += ARROW_GROW_RATE * delta;
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var touch_event = event as InputEventMouseButton;
		
		# When the screen is first clicked
		if touch_event.pressed:
			visible = true;
			#rotation = (current_mouse_position - position).normalized().angle();
			
		# When the screen is released
		else:
			visible = false;
			scale.y = 1;
