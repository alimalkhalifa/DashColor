extends KinematicBody2D
class_name PlayerBody

const SPEED = 96.0
const ACCELERATION = 16.0
const DECCELERATION = 32.0
const AIR_AFTER_TOUCH = 2.0
const GRAVITY = 256.0
const JUMP = -96.0
const DASH_SPEED = 256.0
const DASH_TIME = 0.1

var velocity := Vector2()
var gravity := 0.0
var jump_latch = false
var dash_lock = false
var in_green := false
var in_purple := false

func _ready():
	gravity = GRAVITY
	$Timer.wait_time = DASH_TIME

func _physics_process(delta):
	var horizontal_movement_input := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	var horizontal_velocity := velocity.x
	var vertical_velocity := velocity.y
	
	var acceleration: float
	if dash_lock:
		acceleration = 0
	elif is_on_floor():
		acceleration = AIR_AFTER_TOUCH
	elif (horizontal_velocity > 0 and horizontal_movement_input > 0) or (horizontal_velocity < 0 and horizontal_movement_input < 0):
		acceleration = ACCELERATION
	else:
		acceleration = DECCELERATION
	
	horizontal_velocity = lerp(horizontal_velocity, horizontal_movement_input * SPEED, acceleration * delta)
	if abs(horizontal_velocity) < 1.0:
		horizontal_velocity = 0.0
	
	if is_on_floor():
		vertical_velocity = 0
		if Input.is_action_pressed("command_jump") and not jump_latch:
			vertical_velocity = JUMP if gravity > 0 else -JUMP
			jump_latch = true
	
	if Input.is_action_just_released("command_jump"):
		jump_latch = false
	
	if Input.is_action_just_pressed("command_action"):
		if in_green and abs(horizontal_velocity) > 0:
			horizontal_velocity = DASH_SPEED if horizontal_velocity > 0 else -DASH_SPEED
			dash_lock = true
			$Timer.start()
		if in_purple:
			gravity = -gravity
	
	if not dash_lock:
		vertical_velocity += gravity * delta
	
	velocity = Vector2(horizontal_velocity, vertical_velocity)
	
	velocity = move_and_slide(velocity, Vector2.UP if gravity > 0 else Vector2.DOWN)

func _on_Timer_timeout():
	dash_lock = false
