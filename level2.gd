extends Node2D

@onready var player = get_node("Player")
@onready var music = get_node("AudioStreamPlayer2D")
@onready var trol = load("res://trol.tscn")

func _ready():
	$Platform.show()
	$BackgroundNeon.hide()

func _physics_process(delta):
	music.position = player.position

func stop_sound():
	$AudioStreamPlayer2D.stop()

func begin_boss():
	$AudioStreamPlayer2D.stream = load("res://Assets/Yeu Luuk Liek Mii, But Nawt As Hawt.wav")
	$AudioStreamPlayer2D.play()
	var winor = trol.instantiate()
	add_child(winor)
	winor.position = Vector2(10000, 1000)
	$BackgroundNeon.show()
