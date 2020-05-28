extends AnimationPlayer

onready var player: KinematicBody2D = get_parent()
onready var sprite: AnimatedSprite = player.get_node("AnimatedSprite")
var facing_right = true
var upsidedown = false

func _ready():
	idle()

func _process(_delta):
	if player.velocity.x > 0:
		if not facing_right:
			facing_right = true
			sprite.scale.x = 1
	if player.velocity.x < 0:
		if facing_right:
			facing_right = false
			sprite.scale.x = -1
	if player.gravity > 0:
		if upsidedown:
			upsidedown = false
			sprite.scale.y = 1
	if player.gravity < 0:
		if not upsidedown:
			upsidedown = true
			sprite.scale.y = -1
	
	if not player.is_on_floor():
		if player.velocity.y < 0:
			jump_up()
		elif player.velocity.y > 0:
			jump_down()
	elif abs(player.velocity.x) > 0:
		walk()
	else:
		idle()

func idle():
	if current_animation != "Idle":
		play("Idle")

func walk():
	if current_animation != "Walk":
		play("Walk")

func jump_up():
	if current_animation != "JumpUp":
		play("JumpUp")

func jump_down():
	if current_animation != "JumpDown":
		play("JumpDown")
