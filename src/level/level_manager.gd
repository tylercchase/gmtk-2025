extends Node

@export var game_over_scene: PackedScene

func _ready() -> void:
	var timer = Timer.new()
	timer.autostart = true
	timer.one_shot = true
	add_child(timer)
	timer.start(State.round_time)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var game_over_node = game_over_scene.instantiate()
	add_child(game_over_node)
