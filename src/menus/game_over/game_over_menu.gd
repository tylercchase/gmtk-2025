extends PanelContainer

@export var play_again_button: Button
@export var upgrade_button: Button
@export var main_menu_button: Button
@export var items_collected_label: Label


@export_file("*.tscn") var level_scene: String
@export_file("*.tscn") var upgrade_scene: String
@export_file("*.tscn") var main_menu_scene: String

func _ready() -> void:
    play_again_button.pressed.connect(_on_play_again_button_pressed)
    upgrade_button.pressed.connect(_on_upgrade_button_pressed)
    main_menu_button.pressed.connect(_on_main_menu_button_pressed)

func load_run_stats(items: Dictionary):
    items_collected_label.text = ""
    # do some sorting/filtering here for only the pieces that matter
    for item in items.keys():
        items_collected_label.text += str(items[item]) + "x " + item + "\n"
        if State.inventory.has(item):
            State.inventory[item] += items[item]
        else:
            State.inventory[item] = items[item]

func _on_play_again_button_pressed():
    get_tree().change_scene_to_file(level_scene)

func _on_upgrade_button_pressed():
    get_tree().change_scene_to_file(upgrade_scene)

func _on_main_menu_button_pressed():
    get_tree().change_scene_to_file(main_menu_scene)