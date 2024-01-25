extends StaticBody2D




func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://maps/level1.tscn")
