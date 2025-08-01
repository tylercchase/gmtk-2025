extends Node2D
@export var segment_scene: PackedScene
@export var player_node: Player

@export var trail_line: Line2D

var number_of_segments = 50

var past_locations = []
var segments: Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.autostart = true
	add_child(timer)
	timer.start(0.1)
	timer.timeout.connect(_on_timer_timeout)

# Used to create a new player node in global position after the timer runs out each time.
func _on_timer_timeout():
	trail_line.add_point(player_node.global_position)
	if len(trail_line.points) > number_of_segments:
		trail_line.remove_point(0)
	check_closed_loops()

func check_closed_loops():
	
	pass
