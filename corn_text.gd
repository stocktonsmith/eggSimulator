extends Label

var canvasScene;

var totalCorn;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	totalCorn = get_tree().get_node_count_in_group("CORN_PIECE");
	canvasScene = get_node("../../..");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cornCount = canvasScene.getCornCount();
	text = "Corn: " + str(cornCount) + "/" + str(totalCorn);
