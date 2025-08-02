extends Node

signal tooltip_changed

signal purchased_upgrade

func emit_tooltip_changed(value):
    tooltip_changed.emit(value)

func emit_purchased_upgrade():
    purchased_upgrade.emit()