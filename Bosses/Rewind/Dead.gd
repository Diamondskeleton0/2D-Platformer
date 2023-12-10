extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")
@onready var level = get_node("/root/Game")

func start():
	player.set_animation("Dead")
	level.switchLevel()
	SM.queue_free()

