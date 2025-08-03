extends Node

signal tooltip_changed

signal purchased_upgrade

signal item_collected

signal inventory_changed

func emit_tooltip_changed(value):
    tooltip_changed.emit(value)

func emit_purchased_upgrade():
    purchased_upgrade.emit()

func emit_item_collected(item: Item):
    item_collected.emit(item)

func emit_inventory_changed():
    inventory_changed.emit()