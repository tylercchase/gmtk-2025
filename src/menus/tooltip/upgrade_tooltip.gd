extends PanelContainer

@export var upgrade_title: Label
@export var upgrade_description: RichTextLabel
@export var cost_label: RichTextLabel
func _ready() -> void:
    Events.tooltip_changed.connect(_on_tooltip_changed)
    visible = false

func update_info(upgrade: Upgrade):
    visible = true
    upgrade_title.text = upgrade.name
    upgrade_description.text = upgrade.description
    var total_purchased = 0

    if State.purchased_upgrades.has(upgrade.id):
        total_purchased = State.purchased_upgrades[upgrade.id]

    if total_purchased >= len(upgrade.purchase_prices):
        cost_label.text = "Max Level"
        return
    var current_purchase_price : UpgradeCost = upgrade.purchase_prices[total_purchased]
    cost_label.text = "Costs:"
    if current_purchase_price.resource_id == "apple":
        cost_label.text += "\n [color=red]Apple[/color]: " + str(current_purchase_price.amount)
    elif current_purchase_price.resource_id == "orange":
        cost_label.text += "\n [color=orange]Orange[/color]:" + str(current_purchase_price.amount)




func _process(delta: float) -> void:
    if visible:
        position = get_global_mouse_position() + Vector2(20,20)

func _on_tooltip_changed(value):
    if value == null:
        visible = false
    else:
        update_info(value)