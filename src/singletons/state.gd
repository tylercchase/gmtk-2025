extends Node


### Round time in seconds
var round_time = 15


var purchased_upgrades = {

}


var modifiers_add = {
    "apple": 0,
    "speed": 0
}

var modifiers_multiply = {
    "apple": 1,
    "speed": 1,
}


func get_modifiers(attribute: String, value: Variant) -> Variant:
    var temp = value
    if modifiers_add.has(attribute):
        temp += modifiers_add[attribute]
    if modifiers_multiply.has(attribute):
        temp *= modifiers_multiply[attribute]
    return temp


var inventory = {
    "apple": 0,
    "orange": 0
}

### seconds 'till a new thing spawn
var spawn_tick_rate = 0.5
### chance that something shows up 0.0-1.0 %
var spawn_chance = 0.5
var spawn_rates = {
    "apple": 1.0,
    "orange": 0.0
}