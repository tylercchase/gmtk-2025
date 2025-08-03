class_name StatUpgrade
extends Upgrade

@export var stat_key: String
@export var type: NumberType
@export var value: float

enum NumberType {
    ADD,
    MULTIPLY,
}


func on_buy_level():
    if type == NumberType.MULTIPLY:
        if State.modifiers_multiply.has(stat_key):
            State.modifiers_multiply[stat_key] *= value
        else:
            State.modifiers_multiply[stat_key] = value
    elif type == NumberType.ADD:
        if State.modifiers_add.has(stat_key):
            State.modifiers_add[stat_key] += value
        else:
            State.modifiers_add[stat_key] += value