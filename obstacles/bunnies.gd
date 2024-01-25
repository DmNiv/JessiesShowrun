extends Node2D

func _ready():
	$AnimationPlayer.play("coeio")

func _on_animation_player_animation_finished(coieio):
	queue_free()


