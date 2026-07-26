extends Control

@onready var videoBg = $VideoStreamPlayer
@onready var anim = $AnimationPlayer
@onready var anim2 = $AnimationPlayer2
@onready var play = $play
@onready var options = $options
@onready var options2 = $options2
@onready var exit = $exit
@onready var title = $RichTextLabel

func _ready() -> void:
	options2.visible = false
	videoBg.play()
	anim.play("button_entrance")
	anim2.play("title_entrance")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	options2.visible = true
	exit.visible = false
	play.visible = false
	options.visible = false
	title.visible = false


func _on_button_pressed() -> void:
	options2.visible = false
	exit.visible = true
	play.visible = true
	options.visible = true
	title.visible = true
