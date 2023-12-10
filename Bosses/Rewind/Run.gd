extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")
@onready var enemy = get_node("/root/Game/Player")

func start():
	if enemy.position.x > player.position.x:
		player.set_direction(1)
	else:
		player.set_direction(-1)
	player.set_animation("Move")

func physics_process(delta):
	player.velocity.x += player.direction * player.accel
	if abs(player.velocity.x) >= player.MAXSPEED:
		player.velocity.x -= player.direction * player.decel
	
	player.move_and_slide()

func process(delta):
	if (abs(player.position.x) - abs(enemy.position.x)) < 100 && (abs(player.position.x) - abs(enemy.position.x)) > -100:
		player.velocity.y = player.JUMP_VELOCITY
		SM.set_state("Jump")
