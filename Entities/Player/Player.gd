extends KinematicBody2D

func _ready():
	pass

func _physics_process(delta):
	var horizontal_movement_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
