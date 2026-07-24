extends Node2D

@onready var player = get_node("../Player")
var enemy = preload("res://enemy.tscn")
var spawn_timer = 0.0

func _process(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer <= 0.0:
		spawn_timer = 1.0
		var node = enemy.instantiate()
		var lane_index = randi_range(0,player.lanes_amount)
		node.lane_index = lane_index
		node.position.x = player.position_offset.x + lane_index*player.lanes_distance
		add_child(node)
		if lane_index % 2 == 1:
			node.global_position.y = -node.global_position.y
