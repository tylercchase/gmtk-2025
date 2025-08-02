extends PanelContainer

@export var upgrade_title: Label
@export var upgrade_description: RichTextLabel

func _ready() -> void:
    Events.tooltip_changed.connect(_on_tooltip_changed)
    visible = false

func update_info(upgrade: Upgrade):
    visible = true
    upgrade_title.text = upgrade.name
    upgrade_description.text = upgrade.description



func _process(delta: float) -> void:
    if visible:
        position = get_global_mouse_position() + Vector2(20,20)

func _on_tooltip_changed(value):
    if value == null:
        visible = false
    else:
        update_info(value)