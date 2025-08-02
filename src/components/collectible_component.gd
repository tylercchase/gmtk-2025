class_name CollectibleComponent
extends Area2D

signal collected



func on_interact():
    collected.emit()