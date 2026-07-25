extends Sprite2D

@export var speed = 5
var time = 0

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	time += delta*speed
	var index = int(time)
	if index >= 4:
		time = 0
		index = 0
	frame_coords.x = index
