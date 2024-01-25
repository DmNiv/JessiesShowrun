extends CharacterBody2D


const maxSpeed = 700.0
const acceleration = 10
const JUMP_VELOCITY = -500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var sliding = false
var direction
var pontuacao = 0


func slowDown():
	$AnimationPlayer.play("recover")
	velocity.x = 0

func slide():
	sliding = true
	if velocity.x > 500:
		velocity.x = 800
	elif velocity.x < -500:
		velocity.x = -800
	$Sprite2D.scale.y = 1.25
	$CollisionShape2D.scale.y = 0.5
	
	if is_on_floor():
		pass
func stand():
	sliding = false
	$Sprite2D.scale.y = 2.5
	$CollisionShape2D.scale.y = 1
	
func hitBanana():
	pontuacao += 5
	slowDown()
func hitPie():
	pontuacao += 3
	slowDown()

func _process(delta):
	$Label.text = "Pontuação: " + str(pontuacao)
	
	
	
	


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_pressed("ui_control"):
		slide()
	elif not Input.is_action_pressed("ui_control") and is_on_floor():
		stand()

	# Handle jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
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
		
	if Input.is_action_just_pressed("ui_esc"):
		get_tree().paused = true
		$pauseMenu.show()

	move_and_slide()




func _on_animation_player_animation_finished(recover):
	$Sprite2D.rotation = 0
