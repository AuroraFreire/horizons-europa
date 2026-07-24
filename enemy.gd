extends Node2D

@export var enemy_speed = 40.0
var lane_index = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var mod = 1 if lane_index % 2 == 0 else -1
	position.y += delta * enemy_speed * mod
