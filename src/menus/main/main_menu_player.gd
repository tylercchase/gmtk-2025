extends Player

var timer: Timer

@export var container: Control

func _ready() -> void:
    super()
    timer = Timer.new()
    add_child(timer)
    timer.start(0.5)
    timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
    rotate(rotation_amount * 3)
    timer.start(randf())


func _process(delta: float) -> void:
    global_position = (global_position + (direction.rotated(rotation).normalized() * SPEED * delta)).clamp(container.get_global_rect().position, container.get_global_rect().end)