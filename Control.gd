extends Control





func _on_yeeaaah_pressed():
	get_tree().change_scene_to_file("res://maps/level" + str(get_tree().current_scene.name.to_int() + 1) + ".tscn")
