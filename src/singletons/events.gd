extends Node

signal tooltip_changed


func emit_tooltip_changed(value):
    tooltip_changed.emit(value)