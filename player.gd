extends Node2D

@export var lanes_distance = 90.0
@export var lanes_amount = 6
var lane_index = 0
var position_offset: Vector2

func _ready():
	position_offset = position


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("right"):
		lane_index += 1
		if lane_index >= lanes_amount:
			lane_index = 0
	if Input.is_action_just_pressed("left"):
		lane_index -= 1
		if lane_index < 0:
			lane_index=lanes_amount-1
		
	position.x = lane_index*lanes_distance+position_offset.x
