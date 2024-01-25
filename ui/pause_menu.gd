extends Control





func _on_unpause_pressed():
	hide()
	get_tree().paused = false



func _on_quit_pressed():
	get_tree().quit()
