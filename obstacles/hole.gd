extends Node2D




func _on_area_2d_body_entered(body):
	remove_child($pins)
	
