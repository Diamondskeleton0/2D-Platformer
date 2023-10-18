extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y <= 0:
			$Animation.animation = "Jump"
		else:
			$Animation.animation = "Fall"
	else:
		if abs(velocity.x) > 0:
			get_node("Animation").play("Run")
		else:
			$Animation.animation = "Idle"

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			$Animation.flip_h = false
		else:
			$Animation.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	


	move_and_slide()

