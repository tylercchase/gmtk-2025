extends AnimationPlayer

@export var collectible_component: CollectibleComponent


func _ready() -> void:
    collectible_component.collected.connect(_on_collected)


func start_animation():
    play("default")

func _on_collected():
    start_animation()
