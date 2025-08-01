extends Node2D

@export var item: String
@export var collectible_component: CollectibleComponent

func _ready() -> void:
    collectible_component.collected.connect(_on_collectible_collected)


func _on_collectible_collected():
    add_item()


func add_item():
    print("Give the player" + item)
