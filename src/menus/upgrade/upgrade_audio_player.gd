extends AudioStreamPlayer

func _ready() -> void:
    Events.purchased_upgrade.connect(_on_purchased_upgrade)

func _on_purchased_upgrade():
    play()