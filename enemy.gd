extends Node2D

@export var down_texture: Texture2D
@export var enemy_speed = 40.0
var lane_index = 0
var start_pos = 0

func _ready() -> void:
	if lane_index % 2 == 0:
		$Texture.texture = down_texture

func _process(delta: float) -> void:
	var mod = 1 if lane_index % 2 == 0 else -1
	position.y += delta * enemy_speed * mod
	
	var die = false
	if lane_index % 2 == 0:
		if global_position.y > -start_pos:
			die = true
	else:
		if global_position.y < -start_pos:
			die = true
	if die:
		queue_free()
