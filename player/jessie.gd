extends CharacterBody2D


const maxSpeed = 900.0
const acceleration = 20
const JUMP_VELOCITY = -600.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var sliding = false
var direction
var pontuacao = 0


func slowDown():
	#$AnimationPlayer.play("recover")
	velocity.x = 0

func slide():
	sliding = true
	if velocity.x > 700:
		velocity.x = 1000
	elif velocity.x < -700:
		velocity.x = -1000
	$CollisionShape2D.scale.y = 0.5
	
	if is_on_floor():
		pass
func stand():
	sliding = false
	$CollisionShape2D.scale.y = 1
	
func hitBanana():
	pontuacao += 5
	slowDown()
func hitPie():
	pontuacao += 3
	slowDown()

func _process(delta):
	$Label.text = "Pontuação: " + str(pontuacao)
	
func animate():
	if direction < 0:
		$Sprite2D.flip_h = true
	elif direction > 0:
		$Sprite2D.flip_h = false
	if direction == 0:
		$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("RESET")

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_pressed("ui_control"):
		slide()
	elif not Input.is_action_pressed("ui_control") and is_on_floor():
		stand()

	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	direction = Input.get_axis("ui_a", "ui_d")
	if direction > 0 and sliding == false:
		velocity.x += acceleration
	elif direction < 0 and sliding == false:
		velocity.x -= acceleration
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.05)
	if sliding == false:
		velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)
		
	if Input.is_action_just_pressed("ui_esc"):
		get_tree().paused = true
		$pauseMenu.show()

	animate()
	move_and_slide()
	




func _on_animation_player_animation_finished(recover):
	$Sprite2D.rotation = 0
