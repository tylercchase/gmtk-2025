extends Node2D
@export var segment_scene: PackedScene
@export var player_node: Player

var number_of_segments = 5

var past_locations = []
var segments: Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in number_of_segments:
		var segment = segment_scene.instantiate()
		add_child(segment)
		segment.global_position = player_node.global_position
		segments.push_back(segment)
		segments.reverse()
	var timer = Timer.new()
	timer.autostart = true
	add_child(timer)
	timer.start(0.1)
	timer.timeout.connect(_on_timer_timeout)

# Used to create a new player node in global position after the timer runs out each time.
func _on_timer_timeout():
	past_locations.push_front({
		"location": player_node.global_position,
		"rotation": player_node.rotation
		})
	if len(past_locations) > number_of_segments:
		past_locations.pop_back()
	if len(segments) <= 0:
		return
	for i in len(past_locations):
		segments[i].global_position = past_locations[i].location
		segments[i].rotation = past_locations[i].rotation


