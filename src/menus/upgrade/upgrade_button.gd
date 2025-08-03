class_name UpgradeButton
extends Button



@export var upgrade_resource: Upgrade:
	set(value):
		upgrade_resource = value
		update_display()

@export var purchased_amount_label: Label
var maxed = false
var buyable = false
func _ready() -> void:
	if !Engine.is_editor_hint():
		mouse_entered.connect(_on_mouse_entered)
		mouse_exited.connect(_on_mouse_exited)
		pressed.connect(_on_button_pressed)
	update_display()

	Events.inventory_changed.connect(_on_inventory_changed)

func _on_inventory_changed():
	update_display()


func update_display():
	if Engine.is_editor_hint():
		$Label.text = upgrade_resource.name
	$Label.visible = Engine.is_editor_hint()
	var max_upgrade_count = len(upgrade_resource.purchase_prices)
	var total_purchased = 0

	if State.purchased_upgrades.has(upgrade_resource.id):
		total_purchased = State.purchased_upgrades[upgrade_resource.id]
		purchased_amount_label.text = str(total_purchased) + "/" +str(max_upgrade_count)
		if total_purchased >= max_upgrade_count:
			disabled = true
			maxed = true
	else:
		purchased_amount_label.text = str(0) + "/" +str(max_upgrade_count)
	if disabled or len(upgrade_resource.purchase_prices) == 0:
		return
	# update if we can actually purchase something
	var current_purchase_price : UpgradeCost = upgrade_resource.purchase_prices[total_purchased]
	if State.inventory.has(current_purchase_price.resource_id):
		print(State.inventory[current_purchase_price.resource_id])
		disabled = State.inventory[current_purchase_price.resource_id] > current_purchase_price.amount
		buyable = disabled
	else:
		disabled = true
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

	var price = upgrade_resource.purchase_prices[State.purchased_upgrades[upgrade_resource.id] - 1]
	State.inventory[price.resource_id] = clamp(State.inventory[price.resource_id] - price.amount, 0 , INF)
	print(State.inventory)
	Events.emit_purchased_upgrade()
	Events.emit_inventory_changed()
	update_display()
