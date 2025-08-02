extends PanelContainer


func _ready() -> void:
    Events.tooltip_changed.connect(_on_tooltip_changed)
    visible = false

func update_info(upgrade: Upgrade):
    print(upgrade)
    visible = true


func _process(delta: float) -> void:
    if visible:
        position = get_global_mouse_position() + Vector2(20,20)

func _on_tooltip_changed(value):
    if value == null:
        visible = false
    else:
        update_info(value)