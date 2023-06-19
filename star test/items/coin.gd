extends Area2D

signal coin_collected

func _on_coin_body_entered(_body):
	emit_signal("coin_collected")
	print("collected")
	$coin_sound.play()
	print("stared sound")
	$AnimationPlayer.play("collected")
	

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
