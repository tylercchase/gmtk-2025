class_name SpawnChanceUpgrade
extends Upgrade


func on_buy_level():
    # for now thisi s only going to be for oranges so don't care about making it dynamic
    State.spawn_rates['orange'] += 0.2