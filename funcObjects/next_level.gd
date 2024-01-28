extends StaticBody2D




func _on_area_2d_body_entered(body):
	get_tree().paused = true
	body.get_node("continueLevel").show()
