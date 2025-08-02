@tool
class_name UpgradeButton
extends Button



@export var upgrade_resource: Upgrade:
	set(value):
		upgrade_resource = value
		update_display()

@export var purchased_amount_label: Label
var maxed = false
func _ready() -> void:
	if !Engine.is_editor_hint():
		mouse_entered.connect(_on_mouse_entered)
		mouse_exited.connect(_on_mouse_exited)
		pressed.connect(_on_button_pressed)
	update_display()


func update_display():
	if Engine.is_editor_hint():
		$Label.text = upgrade_resource.name
	$Label.visible = Engine.is_editor_hint()
	var max_upgrade_count = len(upgrade_resource.purchase_prices)
	if State.purchased_upgrades.has(upgrade_resource.id):
		var total_purchased = State.purchased_upgrades[upgrade_resource.id]
		purchased_amount_label.text = str(total_purchased) + "/" +str(max_upgrade_count)
		if total_purchased >= max_upgrade_count:
			disabled = true
			maxed = true
	else:
		purchased_amount_label.text = str(0) + "/" +str(max_upgrade_count)
	# as well as update icon

# need to have some logic here for listening to currency updates and enabling/disabling the button press

func _on_mouse_entered():
	Events.emit_tooltip_changed(upgrade_resource)

func _on_mouse_exited():
	Events.emit_tooltip_changed(null)

func _on_button_pressed():
	upgrade_resource.on_buy_level()
	if State.purchased_upgrades.has(upgrade_resource.id):
		State.purchased_upgrades[upgrade_resource.id] += 1
	else:
		State.purchased_upgrades[upgrade_resource.id] = 1
	update_display()
	Events.emit_purchased_upgrade()
