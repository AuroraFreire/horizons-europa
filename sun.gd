extends Node2D

var timer = randf_range(500, 1000) 
var time = 0
@export var lanes_distance = 90.0
@export var lanes_amount = 6
var lane_index = 0
var position_offset: Vector2
var target_pos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	position.x = (-242)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	time += 2
	if(time >= timer):
		var lane_index = randi_range(0, 5)
		var lanepos = lane_index * lanes_distance - 242.0
		position.x = (lanepos)
		time = 0
		timer == randf_range(500, 1000)
	elif (time != timer):
		print(timer)
		print(time)
		
