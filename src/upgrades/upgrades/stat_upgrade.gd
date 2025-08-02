class_name StatUpgrade
extends Upgrade

@export var stat: Stat
@export var amount: float
@export var type: NumberType
enum Stat {
    SPEED,
    LENGTH
}
enum NumberType {
    ADD,
    SUBTRACT,
    MULTIPLY,
    DIVIDE
}
func on_buy_level():
    pass