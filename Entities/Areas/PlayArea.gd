extends Area2D

func _on_PlayArea_body_exited(body):
	if body is PlayerBody:
		get_node("/root/World").reset_player()
