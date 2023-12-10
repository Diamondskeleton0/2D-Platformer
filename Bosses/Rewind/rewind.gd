extends CharacterBody2D

const MAXSPEED = 100.0
const MAXDASHSPEED = 700.0
const JUMP_VELOCITY = -370.0
var accel = 20.0
var dashAccel = 40.0
var decel = 20.0
var direction = -1
var isDashing = false
var health = 6
var isInvincible = false
var isDead = false

@onready var SM = $StateMachine
@onready var enemy = get_node("/root/Game/Player")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	isDead = false
	SM.set_state("Jump")

func _physics_process(delta):
	if direction == 1:
		$AnimatedSprite2D.flip_h = true
	elif direction == -1:
		$AnimatedSprite2D.flip_h = false
	move_and_slide()
	if health <= 0 && !isDead:
		die()
		isDead = true

func set_animation(anim):
	if $AnimatedSprite2D.animation == anim: return
	if $AnimatedSprite2D.sprite_frames.has_animation(anim): $AnimatedSprite2D.play(anim)
	else: $AnimatedSprite2D.play()

func set_direction(d):
	direction = d

func die():
	SM.set_state("Dead")

func _on_hitbox_area_entered(area):
	var hitbox = area.get_name()
	if hitbox == "HitCollider" && !isInvincible && enemy.isAttacking && SM.state_name == "Idle":
		health -= 1
		$invincibleTime.start()
		isInvincible = true

func _on_invincible_time_timeout():
	isInvincible = false
