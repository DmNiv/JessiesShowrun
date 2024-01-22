extends CharacterBody2D


const maxSpeed = 500.0
const acceleration = 10
const JUMP_VELOCITY = -400.0
var direction

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var sliding = false


func slowDown():
	$AnimationPlayer.play("recover")
	velocity.x = 0

func slide():
	sliding = true
	scale.y = 0.5
	if is_on_floor():
		pass
func stand():
	sliding = false
	scale.y = 1




func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_pressed("ui_control"):
		slide()
	elif Input.is_action_just_released("ui_control"):
		stand()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_a", "ui_d")
	if direction > 0 and sliding == false:
		velocity.x += acceleration
	elif direction < 0 and sliding == false:
		velocity.x -= acceleration
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.025)
	if sliding == false:
		velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)
	print(velocity.x)

	move_and_slide()




func _on_animation_player_animation_finished(recover):
	$Sprite2D.rotation = 0
