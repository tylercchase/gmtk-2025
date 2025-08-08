class_name CollectibleComponent
extends Area2D

signal collected

var is_collected = false


func on_interact():
    # This would stop collectibles from being collected multiple times, but it's kinda funny to leave it in
    # if !is_collected:
    collected.emit()
    # is_collected = true