extends Node2D

@export var random_sprites: Array[Texture2D]
@export var enemy_speed = 40.0
var lane_index = 0

func _ready() -> void:
	if  len(random_sprites) > 0 :
		$Texture.texture = random_sprites[randi_range(0,len(random_sprites)-1)]

func _process(delta: float) -> void:
	var mod = 1 if lane_index % 2 == 0 else -1
	position.y += delta * enemy_speed * mod
