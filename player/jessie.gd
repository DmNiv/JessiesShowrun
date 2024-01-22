extends CharacterBody2D


@export var speed = 300.0
const JUMP_VELOCITY = -400.0
var running
var slowing = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func run():
	speed = 450
	running = true
	
func walk():
	if is_on_floor():
		speed = 300
		running = false

func slowDown():
	slowing = true
	$AnimationPlayer.play("recover")
	$Sprite2D.rotation = 0

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_shift") and is_on_floor() and slowing == false:
		run()
	elif slowing == false:
		walk()
		
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_a", "ui_d")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()




func _on_animation_player_animation_finished(recover):
	slowing = false
