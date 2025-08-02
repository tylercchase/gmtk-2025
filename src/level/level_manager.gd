extends Node

@export var game_over_scene: PackedScene
@export var progress_bar: ProgressBar

@export var player: Player

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
	player.process_mode = Node.PROCESS_MODE_DISABLED
	game_over_node.load_run_stats(current_run_items)


func _process(_delta: float) -> void:
	progress_bar.value =  timer.time_left / timer.wait_time

func _on_item_collected(item: Item):
	var modified_amount = 1
	if State.resource_modifiers_add.has(item.id):
		modified_amount += State.resource_modifiers_add[item.id]
	if State.resource_modifiers_multiply.has(item.id):
		modified_amount *= State.resource_modifiers_multiply[item.id]
	if current_run_items.has(item.id):
		current_run_items[item.id] += modified_amount
	else:
		current_run_items[item.id] = modified_amount
	print(current_run_items)