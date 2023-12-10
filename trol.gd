extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")

func _physics_process(delta):
	position.x = move_toward(position.x, player.position.x, 40)
	position.y = move_toward(position.y, player.position.y, 40)


func _on_area_2d_body_entered(body):
	if body == get_node("/root/Game/Player"):
		get_tree().change_scene_to_file("res://win.tscn")
