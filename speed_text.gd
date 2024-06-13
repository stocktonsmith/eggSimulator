extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var egg = get_tree().get_first_node_in_group("PLAYER_PHYSICS");
	egg.sendEggSpeed.connect(updateSpeedDisplay);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass;
	
func updateSpeedDisplay(eggSpeed):
	text = "Speed: " + str(eggSpeed) + " cm/s";
