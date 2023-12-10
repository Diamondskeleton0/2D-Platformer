extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")
@onready var enemy = get_node("/root/Game/Player")

var charging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start():
	if enemy.position.x > player.position.x:
		player.set_direction(1)
	else:
		player.set_direction(-1)
	charging = true
	player.set_animation("Charge")
	$chargeTime.start()

func physics_process(delta):
	if charging:
		player.velocity.x = 0
	else:
		player.velocity.x += player.direction * player.dashAccel
	

func process(delta):
	if abs(player.velocity.x) - abs(enemy.velocity.x) < 10 && abs(player.velocity.x) - abs(enemy.velocity.x) > -10:
		$coolTime.start()

func _on_charge_time_timeout():
	charging = false

func _on_cool_time_timeout():
	SM.set_state("Idle")
