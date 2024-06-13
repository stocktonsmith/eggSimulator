extends Node2D

# How long it takes for the collection animation
const TWEEN_TIME = 0.5;

# This bool exists so you can't hurry and collect corn twice before it's gone
var collected = false;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_corn_area_body_entered(body: Node2D) -> void:
	if not collected and body.name == "EggPhysicsBody":
		collected = true;
		var corn_sound = $CollectCorn;
		corn_sound.play();
		
		var tween = create_tween();
		tween.parallel().tween_property(self, "position", getCornDestination(position), TWEEN_TIME);
		tween.parallel().tween_property(self, "rotation", rotation + PI, TWEEN_TIME);
		tween.parallel().tween_property(self, "scale", Vector2(0, 0), TWEEN_TIME);
		tween.parallel().tween_property(self, "modulate:a", 0.0, TWEEN_TIME);
		tween.tween_callback(self.queue_free);
		
func getCornDestination(cornStart) -> Vector2:
	var cornDestination = Vector2(cornStart.x, cornStart.y - 150);
	return cornDestination;
