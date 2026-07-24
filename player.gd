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
	if Input.is_action_just_pressed("left"):
		lane_index -= 1
	lane_index = clamp(lane_index,0,lanes_amount-1)
		
	position.x = lane_index*lanes_distance+position_offset.x


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("die")
