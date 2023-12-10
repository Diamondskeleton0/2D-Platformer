extends CharacterBody2D

var canFall = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if(canFall):
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	move_and_slide()

func fall():
	$cutscnWaitTime.start()

func _on_cutscn_wait_time_timeout():
	canFall = true
	$deathTimer.start()

func _on_death_timer_timeout():
	var elevator = get_node("/root/Game/Elevator")
	var bgNeon = get_node("/root/Game")
	var player = get_node("/root/Game/Player")
	elevator.begin_boss()
	bgNeon.begin_boss()
	player.begin_boss()
	queue_free()
