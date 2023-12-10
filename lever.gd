extends Node2D

func _ready():
	$Off.show()
	$On.hide()

func _on_area_2d_body_entered(body):
	if body == get_node("/root/Game/Player"):
		$On.show()
		$Off.hide()
		$Area2D.queue_free()
		var elevator = get_node("/root/Game/Elevator")
		elevator.activatedLevers += 1
		print_debug("Lever activated!")
		if elevator.activatedLevers == 2:
			elevator.spawn_trigger()
