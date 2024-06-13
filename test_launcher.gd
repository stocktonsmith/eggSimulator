extends AnimatableBody2D

var egg;
const LAUNCH_STRENGTH = 5;

var fork_center = Vector2(750, 625);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#constant_linear_velocity = Vector2(200, 200);
	egg = get_node("../EggPhysicsBody");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	constant_linear_velocity.x = (egg.position.x - fork_center.x) * LAUNCH_STRENGTH / (egg.velocity.x + 1.5);
	constant_linear_velocity.y = (egg.position.y - fork_center.y) * LAUNCH_STRENGTH / (egg.velocity.y + 1.5);
	#constant_linear_velocity = (egg.position - fork_center).normalized() * LAUNCH_STRENGTH;
