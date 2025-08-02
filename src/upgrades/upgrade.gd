class_name Upgrade
extends Resource

@export var name: String
@export_multiline var description: String # some way of filling in the description later
@export var id: String

@export var requirements: Array[UpgradeRequirement]