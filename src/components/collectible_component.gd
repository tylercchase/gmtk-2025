class_name CollectibleComponent
extends Area2D

signal collected

var is_collected = false


func on_interact():
    if !is_collected:
        collected.emit()
        is_collected = true