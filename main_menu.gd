extends Control

@onready var videoBg = $VideoStreamPlayer
@onready var anim = $AnimationPlayer
@onready var anim2 = $AnimationPlayer2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	videoBg.play()
	anim.play("button_entrance")
	anim2.play("title_entrance")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
