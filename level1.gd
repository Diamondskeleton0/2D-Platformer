extends Node2D

@onready var boss = load("res://Bosses/Rewind/rewind.tscn")
@onready var player = get_node("Player")
@onready var music = get_node("AudioStreamPlayer2D")
@onready var lvlMusic = load("res://Assets/Down_In_The_Pit_rekindled.mp3")
@onready var bossMusic = load("res://Assets/Yeu Luuk Liek Mii, But Nawt As Hawt.wav")

func _ready():
	$AudioStreamPlayer2D.stream = lvlMusic
	music.play()

func _physics_process(delta):
	music.position = player.position

func _on_boss_trigger_body_entered(body):
	if body == get_node("Player"):
		music.stop()
		$AudioStreamPlayer2D.stream = bossMusic
		music.play()
		var loadedObj = boss.instantiate()
		add_child(loadedObj)
		loadedObj.position = Vector2(8752, -848)
		$bossTrigger.queue_free()

func switchLevel():
	music.stop()
	$switchTime.start()

func _on_switch_time_timeout():
	print_debug("womp womp")
	get_tree().change_scene_to_file("res://level2.tscn")
