extends Node2D

signal goalReached();


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_goal_flag_area_body_entered(body: Node2D) -> void:
	if body.name == "EggPhysicsBody":
		emit_signal("goalReached");
		var goal_sound = $ReachedFlag;
		goal_sound.play();
