#also for iris and liam when they come back
#randomizes the captcha to a 1 in 10 chance of appearing when i switch lanes
#generates the actual captcha itself
extends CanvasLayer

signal passed
@export_range(0.0, 1.0) var instant_pass_chance := 0.3

const tile_sets = {
	"ravens": ["res://raven-002.png"],
	"owls": ["res://owl-004-frame0.png"],
	"suns": ["res://sun.png", "res://sun2.png", "res://sun3.png"],
}

@onready var check_page = $Center/Panel/Margin/VBox/CheckPage
@onready var box = $Center/Panel/Margin/VBox/CheckPage/Row/Box
@onready var status: Label = $Center/Panel/Margin/VBox/CheckPage/Status
@onready var grid_page = $Center/Panel/Margin/VBox/GridPage
@onready var header_label: Label = $Center/Panel/Margin/VBox/GridPage/Header/HeaderLabel
@onready var grid: GridContainer = $Center/Panel/Margin/VBox/GridPage/Grid
@onready var grid_status: Label = $Center/Panel/Margin/VBox/GridPage/GridStatus
@onready var verify_btn: Button = $Center/Panel/Margin/VBox/GridPage/BottomRow/VerifyBtn

var correct_tiles := {}
var target_name := ""

func _ready() -> void:
	visible = false
	box.clicked.connect(_on_box_clicked)
	verify_btn.pressed.connect(_on_verify)

func trigger() -> void:
	if visible:
		return
	visible = true
	get_tree().paused = true
	box.reset()
	status.text = ""
	check_page.visible = true
	grid_page.visible = false

func _on_box_clicked() -> void:
	box.spin()
	status.add_theme_color_override("font_color", Color(0.45, 0.45, 0.45))
	status.text = "verifying..."
	await get_tree().create_timer(randf_range(0.8, 1.6)).timeout
	if randf() < instant_pass_chance:
		_finish()
	else:
		check_page.visible = false
		grid_page.visible = true
		grid_status.text = ""
		_build_grid()

func _build_grid() -> void:
	for child in grid.get_children():
		child.queue_free()
	correct_tiles.clear()
	target_name = tile_sets.keys().pick_random()
	header_label.text = "select all images with %s" % target_name
	var others := []
	for key in tile_sets:
		if key != target_name:
			others.append_array(tile_sets[key])
	var target_count = randi_range(3, 5)
	var slots := []
	for i in range(9):
		slots.append(i < target_count)
	slots.shuffle()
	for is_target in slots:
		var pool = tile_sets[target_name] if is_target else others
		var tile := Button.new()
		tile.toggle_mode = true
		tile.icon = load(pool.pick_random())
		tile.expand_icon = true
		tile.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
		tile.custom_minimum_size = Vector2(72, 72)
		tile.toggled.connect(func(on): tile.modulate = Color(0.55, 0.75, 1.0) if on else Color.WHITE)
		grid.add_child(tile)
		correct_tiles[tile] = is_target

func _on_verify() -> void:
	for tile in correct_tiles:
		if tile.button_pressed != correct_tiles[tile]:
			grid_status.text = "Please try again."
			_build_grid()
			return
	_finish()

func _finish() -> void:
	grid_page.visible = false
	check_page.visible = true
	box.check()
	status.add_theme_color_override("font_color", Color(0.13, 0.62, 0.21))
	status.text = "Verification complete."
	await get_tree().create_timer(0.5).timeout
	visible = false
	get_tree().paused = false
	passed.emit()
