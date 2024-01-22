extends StaticBody2D



func _on_area_2d_body_entered(body):
	$Sprite2D.visible = true


func _on_area_2d_2_body_entered(body):
	print("toioioioinnn")
	body.get_node("Sprite2D").rotate(180*PI/180)
	body.slowDown()
	queue_free()
