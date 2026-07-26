#for iris and liam when they wake up.
#this basically draws the checkbox for the captcha, instead of
#using a ui check box we can draw it so we can have some animations
#like, spinning and checked
extends Control

signal clicked

const idle = 0
const spinning = 1
const checked = 2

var state = idle
var spin_angle = 0.0
var hovered = false

func _process(delta: float) -> void:
	if state == spinning:
		spin_angle += delta * TAU * 1.5
		queue_redraw()

func _gui_input(event: InputEvent) -> void:
	if state == idle and event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		clicked.emit()

func _notification(what: int) -> void:
	if what == NOTIFICATION_MOUSE_ENTER:
		hovered = true
		queue_redraw()
	elif what == NOTIFICATION_MOUSE_EXIT:
		hovered = false
		queue_redraw()

func reset() -> void:
	state = idle
	queue_redraw()

func spin() -> void:
	state = spinning
	spin_angle = 0.0
	queue_redraw()

func check() -> void:
	state = checked
	queue_redraw()

func _draw() -> void:
	var center = size / 2.0
	match state:
		idle:
			var box = Rect2(center - Vector2(14, 14), Vector2(28, 28))
			draw_rect(box, Color(0.93, 0.96, 1.0) if hovered else Color.WHITE)
			draw_rect(box, Color(0.76, 0.76, 0.76), false, 2.0)
		spinning:
			draw_arc(center, 13.0, spin_angle, spin_angle + TAU * 0.75, 24, Color(0.26, 0.52, 0.96), 3.0)
		checked:
			var pts = PackedVector2Array([
				center + Vector2(-11, 1),
				center + Vector2(-3, 9),
				center + Vector2(12, -9),
			])
			draw_polyline(pts, Color(0.13, 0.62, 0.21), 4.0)
