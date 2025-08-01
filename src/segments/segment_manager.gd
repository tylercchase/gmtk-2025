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
	# var test2 = Geometry2D.triangulate_polygon(trail_line.points)
	# test_polygon_node.polygon = test2

	var res = Geometry2D.triangulate_delaunay(trail_line.points)
	# var res = Geometry2D.triangulate_polygon(trail_line.points)
	# var res = Geometry.triangulate_polygon($Other/Shape.polygon)
	test_polygon_node.set_polygon(trail_line.points)# = vec_array

	# var test_array = PackedVector2Array()
	for child in test_output_container.get_children():
		child.queue_free()

	for i in range(0, res.size(), 3):
		var poly: Polygon2D = Polygon2D.new()
		poly.color = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1))

		# Result are indexes from the original polygon points
		var vec_array = PackedVector2Array([test_polygon_node.polygon[res[i]], test_polygon_node.polygon[res[i+1]], test_polygon_node.polygon[res[i+2]]])
		poly.polygon = vec_array
		test_output_container.add_child(poly)

		# test_array.append_array(PackedVector2Array([res[i], res[i+1]]))

	# 	var arr_mesh = ArrayMesh.new()
	# 	var arrays = []
	# 	arrays.resize(Mesh.ARRAY_MAX)
	# 	arrays[Mesh.ARRAY_VERTEX] = vec_array
	# 	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	# 	test_mesh.mesh = arr_mesh
	# pass
