extends Node2D

@export var lanes_distance = 90.0
@export var lanes_amount = 6
var lane_index = 0
var position_offset: Vector2
var target_pos
var restart := false
@onready var sun = get_node("../Sun")
@onready var death_screen = get_node("../HUD Layer/Death")
@onready var death_overlay = get_node("../HUD Layer/DeathOverlay")
@onready var death_sound = get_node("../DeathSFX")
@onready var score_label: Label = get_node("../HUD Layer/ScoreLabel")
@onready var highscore_label: Label = get_node("../HUD Layer/HighScore")
@onready var captcha = get_node("../Captcha")

var died = false
var die_counter = 0.0

var save: ConfigFile
var score = 0.0

func _ready():
	position_offset = position
	target_pos = position.x
	
	save = ConfigFile.new()
	var err = save.load("user://save.txt")
	if err:
		save.set_value("save","highscore",0.0)
		print("new")
	highscore_label.text = "Hs: " + str(int(save.get_value("save","highscore")*5.0))

func die():
	if died:
		return
		
	print(score)
	var old = save.get_value("save","highscore")
	if score > old:
		save.set_value("save","highscore",score)
		save.save("user://save.txt")
		print("new high")
		highscore_label.text = "Hs: " + str(int(score*5.0))
	score = 0
	
	died = true
	death_sound.play()

func _process(delta: float) -> void:
	var can_move = abs(position.x-target_pos) < 25
	if sun.counter <= 0:
		died = true
	if died:
		can_move = false
		die_counter += delta
		if die_counter <= 0.3:
			death_screen.modulate.a = die_counter / 0.3
		elif die_counter <= 0.3+1.0:
			death_overlay.modulate.a = (die_counter-0.3)/1.0
		else:
			if not restart:
				restart = true
			await get_tree().create_timer(0.9).timeout
			get_tree().change_scene_to_file("res://world.tscn")
	else:
		score += delta
		score_label.text = str(int(score*5.0))
	
	var prev_lane = lane_index
	if can_move:
		if Input.is_action_pressed("right"):
			lane_index += 1
		if Input.is_action_pressed("left"):
			lane_index -= 1
	lane_index = clamp(lane_index,0,lanes_amount-1)
	#changed lane = 1 in 10 captcha roll. mashing into the wall doesnt count
	if lane_index != prev_lane and randi() % 10 == 0:
		captcha.trigger()
		
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
	die()
