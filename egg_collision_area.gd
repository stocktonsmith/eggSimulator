extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# When egg collides with goal flag
func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("COLLISION! ", area.is_in_group("basicSurface"));
	var reached_flag_sound = get_node("../../../../SoundNode/ReachedFlag");
	reached_flag_sound.play();


func _on_cabinet_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("COLLIDE WITH FRIDGE");
