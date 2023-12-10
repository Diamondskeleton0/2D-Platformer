extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")
@onready var enemy = get_node("/root/Game/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start():
	player.set_direction(0)
	player.set_animation("Idle")
	$waitTime.start()

func physics_process(delta):
	player.velocity.x = move_toward(player.velocity.x, 0, player.decel)
	player.move_and_slide()

func _on_wait_time_timeout():
	if enemy.position.x > player.position.x:
		player.set_direction(1)
	else:
		player.set_direction(-1)
	var rng = RandomNumberGenerator.new()
	var attack = rng.randi_range(1, 2)
	print_debug(attack)
	if attack == 1:
		SM.set_state("Run")
	elif attack == 2:
		SM.set_state("Sprint")
