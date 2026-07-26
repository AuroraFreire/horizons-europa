extends Node2D

@onready var panel = $CanvasLayer/Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.visible = false
	panel.process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func menu():
	pass

func _input(event):
	if event.is_action_pressed("menu"):
		panel.visible = true
		get_tree().paused = true
		


func _on_back_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_back_2_pressed() -> void:
	panel.visible = false
	get_tree().paused = false
