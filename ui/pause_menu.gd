extends Control





func _on_unpause_pressed():
	hide()
	get_tree().paused = false



func _on_quit_pressed():
	get_tree().quit()


func _on_retry_pressed():
	get_tree().change_scene_to_file("res://maps/level" + str(get_tree().current_scene.name.to_int()) + ".tscn")
