extends PanelContainer

@export var currency_label: RichTextLabel

@export var main_menu_button: Button
@export var level_button: Button

@export_file("*.tscn") var main_menu_scene: String
@export_file("*.tscn") var level_scene: String

var template = ""

func _ready() -> void:
    template = currency_label.text
    update_text()
    Events.inventory_changed.connect(_on_inventory_changed)
    main_menu_button.pressed.connect(_on_main_menu_button_pressed)
    level_button.pressed.connect(_on_level_button_pressed)

func _on_main_menu_button_pressed():
    get_tree().change_scene_to_file(main_menu_scene)

func _on_level_button_pressed():
    get_tree().change_scene_to_file(level_scene)


func _on_inventory_changed():
    update_text()


func update_text():
    if State.inventory.has("apple"):
        currency_label.text = template % State.inventory["apple"]