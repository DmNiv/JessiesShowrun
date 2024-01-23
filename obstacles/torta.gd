extends Node2D



func _on_area_2d_body_entered(body):
	$RigidBody2D/Sprite2D.visible = true
	$RigidBody2D.set_deferred("freeze", false)


func _on_area_2d_2_body_entered(body):
	body.hitPie()
	$AudioStreamPlayer2D.play()
	$RigidBody2D/Area2D2.set_deferred("monitoring", false)
	$RigidBody2D/CollisionShape2D.set_deferred("disabled", true)
	visible = false
	



func _on_audio_stream_player_2d_finished():
	queue_free()
