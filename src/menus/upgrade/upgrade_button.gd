extends Button



@export var upgrade_resource: Upgrade

var current_level = 0


func _ready() -> void:
    mouse_entered.connect(_on_mouse_entered)
    mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
    Events.emit_tooltip_changed(upgrade_resource)

func _on_mouse_exited():
    Events.emit_tooltip_changed(null)