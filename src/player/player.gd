class_name Player
extends Area2D

@export var SPEED = 200

var direction = Vector2(0,-1)
var rotation_amount = 0.04

var screen_size # Size of the game window.

var target_angle = rotation
func _ready():
	screen_size = get_viewport_rect().size



func _process(delta: float) -> void:
	var current_speed = State.get_modifiers("speed", SPEED)
	global_position = (global_position + (direction.rotated(rotation).normalized() * current_speed * delta)).clamp(
	 Vector2.ZERO,
	 screen_size
	)
	if Input.is_action_pressed("move_right"):
		target_angle += rotation_amount
	elif Input.is_action_pressed("move_left"):
		target_angle -= rotation_amount
	rotation = lerp_angle(rotation, target_angle, 0.1)
