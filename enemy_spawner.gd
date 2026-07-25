extends Node2D

@onready var player = get_node("../Player")
var spawn_timer = 0.0

@export var enemy_types: Array[PackedScene]
var potential_spawn_positions = []

func regenerate_spawn_positions():
	for i in range(player.lanes_amount):
		for j in range(2):
			potential_spawn_positions.append(i)

func _process(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer <= 0.0:
		spawn_timer = 1.5
		var node = enemy_types[randi_range(0,len(enemy_types)-1)].instantiate()
		if len(potential_spawn_positions) == 0:
			regenerate_spawn_positions()
		var lane_index = potential_spawn_positions.pop_at(randi_range(0,len(potential_spawn_positions)-1))
		node.lane_index = lane_index
		node.position.x = player.position_offset.x + lane_index*player.lanes_distance
		add_child(node)
		if lane_index % 2 == 1:
			node.global_position.y = -node.global_position.y
		node.start_pos = node.global_position.y
