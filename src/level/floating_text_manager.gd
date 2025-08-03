extends Node2D

@export var floating_text: PackedScene


func _ready() -> void:
    Events.float_text.connect(_on_float_text)


func _on_float_text(text, new_position):
    var temp = floating_text.instantiate()
    add_child(temp)
    temp.show_value(text, new_position)