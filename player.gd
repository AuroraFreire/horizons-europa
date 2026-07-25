extends Node2D

@export var lanes_distance = 90.0
@export var lanes_amount = 6
var lane_index = 0
var position_offset: Vector2
var target_pos
@onready var sun = get_node("../Sun")

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
	var lerp_speed = 0.01 + 0.02 * (1.0-sun.counter)
	position.x = lerp(position.x,target_pos,1.0-lerp_speed**(delta))
	var const_speed = 100 - 80 * (1.0-sun.counter)
	# move towards new position with fixed speed too
	if target_pos > position.x:
		position.x = min(position.x+delta*const_speed,target_pos)
	if target_pos < position.x:
		position.x = max(position.x-delta*const_speed,target_pos)

func _on_area_2d_area_entered(_area: Area2D) -> void:
	print("die")
