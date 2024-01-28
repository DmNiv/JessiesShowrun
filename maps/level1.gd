extends Node2D

func _ready():
	get_tree().paused = true
	$Jessie/presentation.get_node("AnimationPlayer").play("level")
