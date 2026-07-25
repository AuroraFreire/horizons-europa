extends Node2D

@export var lanes_distance = 90.0
@export var lanes_amount = 6
var lane_index = 0
var position_offset: Vector2
var target_pos

func _ready():
	position_offset = position
	target_pos = position.x

func _process(delta: float) -> void:
	var can_move = abs(position.x-target_pos) < 25
	
	if can_move:
		if Input.is_action_pressed("right"):
			lane_index += 1
		if Input.is_action_pressed("left"):
			lane_index -= 1
	lane_index = clamp(lane_index,0,lanes_amount-1)
		
	target_pos = lane_index*lanes_distance+position_offset.x
	
	# smoothly lerp to new target position
	position.x = lerp(position.x,target_pos,1.0-0.01**(delta))
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("die")
