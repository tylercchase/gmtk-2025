extends PanelContainer

@export var start_button: Button
@export var upgrade_button: Button
@export var quit_button: Button

@export_file("*.tscn") var level_scene: String
@export_file("*.tscn") var upgrade_scene: String

func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	upgrade_button.pressed.connect(_on_upgrade_button_pressed)


func _on_start_button_pressed():
	# ideally we have a scene transition thing setup here
	get_tree().change_scene_to_file(level_scene)

func _on_upgrade_button_pressed():
	get_tree().change_scene_to_file(upgrade_scene)