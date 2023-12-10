extends CharacterBody2D

const accel = 40.0
const decel = 80.0
const MAXSPEED = 400.0
const PUNCHSPD = 650.0
const JUMP_VELOCITY = -950.0
var punchesAvailable = 1
var isAttacking = false
var lastDir = 1
var jumping = false

#Coyote time variables, it feels wrong without this feature
var coyoteFrames = 8
var coyote = false
var lastFloor = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$CoyoteTimer.wait_time = coyoteFrames / 60.0

func _physics_process(delta):
	# Add the gravity.
	if velocity.y >= 0:
		jumping = false
	
	if isAttacking == true:
		velocity.x = lastDir * PUNCHSPD
		velocity.y = 0
		$Animation.animation = "Attack"
		$AnimationNeon.animation = "Attack"
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
			if velocity.y <= -350:
				$Animation.animation = "Jump"
				$AnimationNeon.animation = "Jump"
			elif velocity.y > -350 && velocity.y <= -100:
				$Animation.animation = "JumpLight"
				$AnimationNeon.animation = "JumpLight"
			elif velocity.y > -100 && velocity.y <= 100:
				$Animation.animation = "IdleAir"
				$AnimationNeon.animation = "IdleAir"
			else:
				$Animation.animation = "Fall"
				$AnimationNeon.animation = "Fall"
		else:
			if punchesAvailable == 0:
				punchesAvailable += 1
			if abs(velocity.x) > 0:
				get_node("Animation").play("Run")
				get_node("AnimationNeon").play("Run")
			else:
				$Animation.animation = "Idle"
				$AnimationNeon.animation = "Idle"

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		if isAttacking:
			isAttacking = false
		velocity.y = JUMP_VELOCITY
		jumping = true
	
	# Handle attack
	if Input.is_action_just_pressed("attack") and punchesAvailable > 0:
		punchesAvailable -= 1
		isAttacking = true
		$AttackTimer.start()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		if !isAttacking:
			if direction != 0:
				lastDir = direction
			if !is_on_floor():
				velocity.x += direction * (accel / 4)
			else:
				velocity.x += direction * accel
			if abs(velocity.x) >= MAXSPEED:
				if !is_on_floor():
					velocity.x -= direction * (decel / 8)
				else:
					velocity.x -= direction * decel
			if direction > 0:
				$Animation.flip_h = false
				$AnimationNeon.flip_h = false
			else:
				$Animation.flip_h = true
				$AnimationNeon.flip_h = true
	else:
		if !isAttacking:
			if !is_on_floor():
				velocity.x = move_toward(velocity.x, 0, decel / 4)
			else:
				velocity.x = move_toward(velocity.x, 0, decel)
	
	
	move_and_slide()
	
	if is_on_floor() and jumping:
		jumping = false
	if !is_on_floor() and lastFloor and !jumping:
		coyote = true
		$CoyoteTimer.start()
	lastFloor = is_on_floor()

func _on_attack_timer_timeout():
	isAttacking = false
	
func _on_coyote_timer_timeout():
	coyote = false
	
func begin_boss():
	$AnimationNeon.show()
