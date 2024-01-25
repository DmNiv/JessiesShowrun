extends CharacterBody2D


const maxSpeed = 500.0
const acceleration = 10
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var sliding = false
var direction
var pontuacao = 0


func slowDown():
	$AnimationPlayer.play("recover")
	velocity.x = 0

func slide():
	sliding = true
	if velocity.x > 300:
		velocity.x = 600
	elif velocity.x < -300:
		velocity.x = -600
	$Sprite2D.scale.y = 0.813/2
	$CollisionShape2D.scale.y = 0.5
	$CollisionShape2D.position.y = 13
	$CollisionShape2D2.scale.y = 0.5
	$CollisionShape2D2.position.y = -6
	
	if is_on_floor():
		pass
func stand():
	sliding = false
	$Sprite2D.scale.y = 0.813
	$CollisionShape2D.scale.y = 1
	$CollisionShape2D.position.y = 26
	$CollisionShape2D2.scale.y = 1
	$CollisionShape2D2.position.y = -13
	
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

	move_and_slide()




func _on_animation_player_animation_finished(recover):
	$Sprite2D.rotation = 0
