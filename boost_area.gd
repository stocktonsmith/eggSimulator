extends Area2D

signal hitSpeedBoost(boostSpeed: float, boostAngle: float);
const BOOST_SPEED = 1200;

var boost_sprite;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boost_sprite = get_node("../");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	var boostAngle = boost_sprite.transform.get_rotation();
	emit_signal("hitSpeedBoost", BOOST_SPEED, boostAngle);
	pass # Replace with function body.
