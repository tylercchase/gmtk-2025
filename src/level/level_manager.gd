extends Node

@export var game_over_scene: PackedScene
@export var progress_bar: ProgressBar

@export var player: Player

var timer: Timer
func _ready() -> void:
	timer = Timer.new()
	timer.autostart = true
	timer.one_shot = true
	add_child(timer)
	timer.start(State.round_time)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	var game_over_node = game_over_scene.instantiate()
	add_child(game_over_node)
	player.process_mode = Node.PROCESS_MODE_DISABLED


func _process(delta: float) -> void:
	progress_bar.value =  timer.time_left / timer.wait_time
