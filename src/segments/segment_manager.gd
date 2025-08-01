extends Node2D
@export var segment_scene: PackedScene
@export var player_node: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.autostart= true
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Used to create a new player node in global position after the timer runs out each time.
func _on_timer_timeout():
	print(player_node.global_position)
	var segment = segment_scene.instantiate()
	add_child(segment)
	segment.global_position = player_node.global_position
