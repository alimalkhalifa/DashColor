extends Area2D

signal finished

func _ready():
	connect("finished", get_node("/root/World"), "on_finished")

func _on_Finish_body_entered(body):
	if body is PlayerBody:
		emit_signal("finished")
