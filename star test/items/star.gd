extends RigidBody2D

@onready var root =  get_tree().root.get_child(0)

func _on_tree_exiting():
	root.shoots -= 1

func _on_screen_exited():
	queue_free()
