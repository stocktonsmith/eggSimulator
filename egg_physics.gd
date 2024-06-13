extends RigidBody2D

var velocity;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var egg = get_parent();
	print("EGG: ", egg);
	velocity = egg.get_velocity();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_RigidBody2D_body_entered(body):
	# Handle bouncing off surfaces
	#velocity = velocity.bounce(get_collision_normal());
	print("COLLISION!");


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("goal reached!");
	var reached_flag_sound = $ReachedFlag;
	reached_flag_sound.play();
	pass # Replace with function body.
