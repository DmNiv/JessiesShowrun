extends CharacterBody2D


const maxSpeed = 900.0
const acceleration = 20
const JUMP_VELOCITY = -650.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var sliding = false
var direction
var pontuacao = 0
var slow = false
var dash = 1


func slowDown():
	slow = true
	#$AnimationPlayer.play("recover")
	velocity.x = 0
	$recover.start()
	await $recover.timeout
	slow = false
	

func slide():
	sliding = true
	if dash == 1:
		dash = 0
		if velocity.x > 700:
			velocity.x = 1000
		elif velocity.x < -700:
			velocity.x = -1000
	$CollisionShape2D.scale.y = 0.5
	$CollisionShape2D2.scale.y = 0.5
	$CollisionShape2D2.position.y = 0
func stand():
	if dash == 0:
		dash = 1
	sliding = false
	$CollisionShape2D.scale.y = 1
	$CollisionShape2D2.scale.y = 1
	$CollisionShape2D2.position.y = -50
func hitBanana():
	pontuacao += 5
	slowDown()
func hitPie():
	pontuacao += 3
	slowDown()

func _process(delta):
	$Label.text = "Pontuação: " + str(pontuacao) + "\nVelocidade x, y: " + str(velocity)
	
	
func animate():
	if direction != 0:
		$AnimationPlayer.play("run")
		if direction < 0:
			$Sprite2D.flip_h = true
		elif direction > 0:
			$Sprite2D.flip_h = false
	elif sliding == true and velocity.x < 100:
		$AnimationPlayer.play("crouchIdle")
	else:
		$AnimationPlayer.play("idle")

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
	if direction > 0 and sliding == false and slow == false:
		velocity.x += acceleration
	elif direction < 0 and sliding == false and slow == false:
		velocity.x -= acceleration
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.05)
	if sliding == false:
		velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)
		
	if sliding == true and velocity.y > 3000:
		$CollisionShape2D.disabled = true
		velocity.y = -300
		velocity.x = 300 * direction
		await get_tree().create_timer(0.2).timeout
		$CollisionShape2D.disabled = false
		
	if Input.is_action_just_pressed("ui_esc"):
		get_tree().paused = true
		$pauseMenu.show()

	animate()
	move_and_slide()
	




func _on_animation_player_animation_finished(recover):
	$Sprite2D.rotation = 0
