extends ColorRect

@onready var sun = get_node("../../Sun")

func _process(delta: float) -> void:
	scale.y = sun.counter
