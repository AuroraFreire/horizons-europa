extends Node2D

var timer = randf_range(500, 1000) 
var time = 0
var counter = 1
@export var lanes_amount = 6
@onready var player = get_node("../Player")
@onready var sun = get_node("../Sun")
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
		lane_index = randi_range(0, 5)
		var lanepos = lane_index * player.lanes_distance - 242.0
		position.x = (lanepos)
		time = 0
		timer = randf_range(500, 1000)
	elif (time != timer):
		print(timer)
		print(time)
	if(player.lane_index != sun.lane_index): 
			counter -= _delta
			if(counter <= 0):
				print("dead")
	elif(player.lane_index == sun.lane_index):
		counter += 1 
