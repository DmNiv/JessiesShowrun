extends Node2D

func _ready():
	$Node2D/Label.text = "Level " + str(get_tree().current_scene.name.to_int())
	$AnimationPlayer.play("level")
	
	
	


func _on_animation_player_animation_finished(level):
	get_tree().paused = false
	queue_free()
