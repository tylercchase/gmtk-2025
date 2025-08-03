class_name Player
extends Area2D

@export var SPEED = 200

var direction = Vector2(0,-1)
var rotation_amount = 75

var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size

func _input(_event: InputEvent) -> void:
	# some way of turning faster here
	if Input.is_action_just_pressed("move_right"):
		rotate(-rotation_amount)
	elif Input.is_action_just_pressed("move_left"):
		rotate(rotation_amount)


func _process(delta: float) -> void:
	var current_speed = State.get_modifiers("speed", SPEED)
	global_position = (global_position + (direction.rotated(rotation).normalized() * current_speed * delta)).clamp(
	 Vector2.ZERO,
	 screen_size
	)
