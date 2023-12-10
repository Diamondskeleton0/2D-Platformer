extends Node2D

@export var offset = Vector2(0, -300)
@export var duration = 4.0
var movePhase = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = get_node("waitTime")
	timer.set_wait_time((duration / 2) + 1)
	start_tween()
	timer.start()

func start_tween():
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	
	tween.set_loops().set_parallel(false)
	if movePhase == 1:
		tween.tween_property($AnimatableBody2D, "position", offset, duration / 2)
	if movePhase == 2:
		tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, duration / 2)

func _on_wait_time_timeout():
	if movePhase == 1:
		movePhase = 2
	else:
		movePhase = 1
	start_tween()
