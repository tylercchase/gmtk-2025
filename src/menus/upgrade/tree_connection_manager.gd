extends Node2D

@export var upgrade_container: Node2D

var upgrade_buttons : Dictionary[String, UpgradeButton] = {

}

func _ready() -> void:
	update_button_object()
	Events.purchased_upgrade.connect(_on_purchased_upgrade)

func update_button_object():
	for child in upgrade_container.get_children():
		var button = child as UpgradeButton
		upgrade_buttons[button.upgrade_resource.id] = button



func check_button_enabled(upgrade: Upgrade):
	if len(upgrade.requirements) == 0:
		return true
	for requirement in upgrade.requirements:
		if State.purchased_upgrades.has(requirement.id) and State.purchased_upgrades[requirement.id] >= requirement.level:
			pass
		else:
			return false
	return true

func update_button_visibility():
	for button in upgrade_buttons.values():
		var resource = button.upgrade_resource
		button.visible = check_button_enabled(resource)
	for button in upgrade_buttons.values():
		if !button.visible:
			for requirement in button.upgrade_resource.requirements:
				if upgrade_buttons.has(requirement.id) and upgrade_buttons[requirement.id].visible and !upgrade_buttons[requirement.id].disabled:
					button.visible = true
					button.disabled = true
					break

func _draw() -> void:
	update_button_visibility()
	update_connections()

func update_connections():
	for button in upgrade_buttons.values():
		var resource = button.upgrade_resource
		var requirements : Array[UpgradeRequirement] = resource.requirements
		if len(resource.requirements) > 0:
			for requirement in requirements:
				if upgrade_buttons.has(requirement.id):
					if upgrade_buttons[requirement.id].visible and button.visible:
						var base_coords = button.global_position + button.get_global_rect().size / 2
						var dest_coords = upgrade_buttons[requirement.id].global_position + upgrade_buttons[requirement.id].get_global_rect().size / 2
						if !button.disabled or button.maxed or !button.buyable:
							draw_line(base_coords, dest_coords, Color.WHITE, 15.0)
						else:
							draw_dashed_line(base_coords, dest_coords, Color.WHITE, 15.0, 20.0)

func _on_purchased_upgrade():
	queue_redraw()
