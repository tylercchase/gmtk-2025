class_name Upgrade
extends Resource

@export var name: String
@export_multiline var description: String # some way of filling in the description later
@export var id: String

@export var purchase_prices: Array[UpgradeCost] # maybe needs a resource here for different types of currencies?? or an enum
# also acts as a max-level count by the amount of purchase prices listed


@export var requirements: Array[UpgradeRequirement]


func on_buy_level(): # I wish we were in godot 4.5, where there's abstract classes ;-;
    pass
