extends Node

@export var game_over_scene: PackedScene
@export var progress_bar: ProgressBar

@export var player: Player
@export var low_time_vignette: ColorRect

var timer: Timer

var current_run_items = {

}

func _ready() -> void:
	timer = Timer.new()
	timer.autostart = true
	timer.one_shot = true
	add_child(timer)
	timer.start(State.round_time)
	timer.timeout.connect(_on_timer_timeout)
	Events.item_collected.connect(_on_item_collected)

func _on_timer_timeout():
	var game_over_node = game_over_scene.instantiate()
	add_child(game_over_node)
	game_over_node.process_mode = Node.PROCESS_MODE_ALWAYS
	get_parent().process_mode = Node.PROCESS_MODE_DISABLED
	game_over_node.load_run_stats(current_run_items)


func _process(_delta: float) -> void:
	progress_bar.value =  timer.time_left / timer.wait_time
	low_time_vignette.material.set("shader_parameter/radius", (1.0 - progress_bar.value) * 0.7)

func _on_item_collected(item: Item, node: Node):
	var modified_amount = State.get_modifiers(item.id, 1)
	if current_run_items.has(item.id):
		current_run_items[item.id] += modified_amount
	else:
		current_run_items[item.id] = modified_amount
	Events.emit_float_text("+" + str(modified_amount) + " " + item.name, node.global_position)