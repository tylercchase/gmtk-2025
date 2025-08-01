extends Node2D
@export var segment_scene: PackedScene
@export var player_node: Player

@export var trail_line: Line2D
@export var collision_shape: CollisionPolygon2D
@export var test_polygon_node: Polygon2D
@export var test_polygon_node_2: Polygon2D
@export var test_output_container: Node2D
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
	if len(trail_line.points) > 0:
		check_closed_loops()

func check_closed_loops():
	var points_array =  trail_line.points
	var new_segment_start = points_array[points_array.size() - 2]
	var new_segment_end = points_array[points_array.size() - 1]

	for i in range(1, points_array.size() - 2): # Iterate through all segments, excluding the last two
		var existing_segment_start = points_array[i - 1]
		var existing_segment_end = points_array[i]

		var intersection = Geometry2D.segment_intersects_segment(
			new_segment_start, new_segment_end,
			existing_segment_start, existing_segment_end
		)

		if intersection != null:
			print("Loop closure detected!")
			test_polygon_node_2.set_polygon(points_array.slice(i))
