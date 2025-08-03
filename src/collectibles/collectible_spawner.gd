extends Node2D

@export var apples: PackedScene
@export var oranges: PackedScene

var all_spawned_nodes = []
@export var player: Player

func get_item_to_spawn() -> PackedScene:
    var possible_items = State.spawn_rates.keys()
    var weights: Array = possible_items.map(get_weights)
    var rng: RandomNumberGenerator = RandomNumberGenerator.new()

    var selected_item = possible_items[rng.rand_weighted(weights)]
    var selected_item_scene: PackedScene
    if selected_item == 'orange':
        selected_item_scene = oranges
    else: #always default to apples /shrug
        selected_item_scene = apples
    return selected_item_scene

var timer: Timer

func _ready() -> void:
    timer = Timer.new()
    add_child(timer)
    timer.start(State.spawn_tick_rate)
    timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
    if randf() > State.spawn_chance:
        return
    var scene = get_item_to_spawn()
    var temp_node = scene.instantiate()
    add_child(temp_node)
    # find position stuff here
    var coords: Vector2
    while true:
        var extent: Rect2 = get_viewport_rect()
        coords = Vector2(randf_range(extent.position.x, extent.end.x), randf_range(extent.position.y, extent.end.y))
        var passed = true
        if coords.distance_to(player.global_position) > 20:
            for previous in all_spawned_nodes:
                if previous == null:
                    continue
                elif coords.distance_to(previous.global_position) < 20:
                    passed = false
                    break
        if passed:
            break
    temp_node.global_position = coords




    all_spawned_nodes.push_back(temp_node)



func get_weights(item: String) -> float:
    return State.spawn_rates[item]