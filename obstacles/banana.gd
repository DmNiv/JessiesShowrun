extends StaticBody2D



func _on_area_2d_body_entered(body):
	$Area2D2/Sprite2D.visible = true
	


func _on_area_2d_2_body_entered(body):
	body.get_node("Sprite2D").rotate(180*PI/180)
	body.slowDown()
	$AudioStreamPlayer2D.play()
	$Area2D2.set_deferred("monitoring", false)
	visible = false
	
	



func _on_audio_stream_player_2d_finished():
	queue_free()
