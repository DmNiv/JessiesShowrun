extends StaticBody2D

@onready var bunnies = preload("res://obstacles/bunnies.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")




func _on_area_2d_body_entered(body):
	print("oi")
	body.get_node("Camera2D").add_child(bunnies.instantiate())
	queue_free()
