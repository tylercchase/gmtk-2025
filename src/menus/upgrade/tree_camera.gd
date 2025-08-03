extends Camera2D


var mouse_start_pos
var screen_start_position

var dragging = false

@export var test: Node
func _input(event):
	if event.is_action("drag"):
		if event.is_pressed():
			mouse_start_pos = event.position
			screen_start_position = position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position =  (mouse_start_pos - event.position) + screen_start_position
	elif event.is_action("scroll_up"):
		test.scale *= 1.1
	elif event.is_action("scroll_down"):
		test.scale *= 0.9