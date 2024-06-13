extends Node

var cornCount = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass;

# When corn is collected
func _on_corn_container_child_exiting_tree(node: Node) -> void:
	cornCount += 1;
	
func getCornCount() -> int:
	return cornCount;
