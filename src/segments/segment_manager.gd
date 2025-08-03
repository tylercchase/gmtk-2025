extends Node2D
@export var segment_scene: PackedScene
@export var player_node: Player

@export var trail_line: Line2D
@export var test_polygon_node_2: Polygon2D

@export var area_collision_shape: CollisionShape2D
@export var area: Area2D

var number_of_segments = 50

var past_locations = []
var segments: Array[Node2D] = []

@export var shake_node: ShakerComponent2D
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
	if len(trail_line.points) > State.get_modifiers("worm-length", number_of_segments):
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
			var temp = points_array.slice(i)
			if len(temp) % 2:
				temp.remove_at(len(temp)-1)
			test_polygon_node_2.set_polygon(temp) # white debug shape
			test_polygon_node_2.color = Color("1f1f1f66")
			var tween = get_tree().create_tween()
			tween.tween_property(test_polygon_node_2, "color", Color("1f1f1f00"), 0.5)
			if shake_node:
				shake_node.play_shake()
			area_collision_shape.shape.set_points(temp)
			await Engine.get_main_loop().process_frame
			await Engine.get_main_loop().process_frame
			for item in area.get_overlapping_areas():
				if item.has_method("on_interact"):
					item.on_interact()
