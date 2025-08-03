extends Node

signal tooltip_changed

signal purchased_upgrade

signal item_collected

signal inventory_changed

signal float_text

func emit_tooltip_changed(value):
    tooltip_changed.emit(value)

func emit_purchased_upgrade():
    purchased_upgrade.emit()

func emit_item_collected(item: Item, node: Node):
    item_collected.emit(item, node)

func emit_inventory_changed():
    inventory_changed.emit()

func emit_float_text(text, position):
    float_text.emit(text, position)