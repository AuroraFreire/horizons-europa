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

@onready var player_texture = player.get_node("Texture")

func _ready() -> void:
	pass # Replace with function body.
	position.x = (-242)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += 2
	player_texture.speed = 5.0 * (counter / 2.0 + 0.5)
	if(time >= timer):
		lane_index = randi_range(0, 5)
		var lanepos = lane_index * player.lanes_distance - 242.0
		position.x = (lanepos)
		time = 0
		timer = randf_range(500, 1000)
	if(player.lane_index != sun.lane_index): 
		counter = max(counter-delta/2.5,0.0)
		if(counter <= 0):
			pass
	elif(player.lane_index == sun.lane_index):
		counter = min(counter+delta*2.0,1.0)
