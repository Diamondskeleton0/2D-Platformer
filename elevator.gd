extends Node2D

@export var offset = Vector2(0, -320)
@export var duration = 10.0
@onready var level = get_node("/root/Game")
var activatedLevers = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_trigger():
	print_debug("Get to the boss!")

func begin_boss():
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	$AnimatableBody2D/Sprite2D.hide()
	$AnimatableBody2D/AnimatedSprite2D.show()
	$AnimatableBody2D/AnimatedSprite2D.play("moving")
	tween.tween_property($AnimatableBody2D, "position", offset, duration / 2)


func _on_boss_trigger_body_entered(body):
	if body == get_node("/root/Game/Player") && activatedLevers == 2:
		var fakePlatform = get_node("/root/Game/MovingPlatformFake")
		level.stop_sound()
		fakePlatform.fall()
