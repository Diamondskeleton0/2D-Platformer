extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.set_animation("Jump")

func physics_process(delta):
	player.velocity.y += (player.gravity / 3) * delta
	if player.direction: 
		player.velocity.x += player.direction * player.accel
		if abs(player.velocity.x) >= player.MAXSPEED:
			player.velocity.x -= player.direction * player.decel
	player.move_and_slide()
	
	if player.is_on_floor():
		player.velocity.y = 0
		SM.set_state("Idle")
	
func process(delta):
	if !player.is_on_floor():
		if player.velocity.y <= -350:
			player.set_animation("Jump")
		elif player.velocity.y > -350 && player.velocity.y <= -100:
			player.set_animation("JumpLight")
		elif player.velocity.y > -100 && player.velocity.y <= 100:
			player.set_animation("IdleAir")
		else:
			player.set_animation("Fall")
