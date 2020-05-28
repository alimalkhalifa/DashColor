extends Area2D

export(Color) var color
onready var polygon := Polygon2D.new()

func _on_GreenArea_body_entered(body):
	if body is PlayerBody:
		body.in_green = true

func _on_GreenArea_body_exited(body):
	if body is PlayerBody:
		body.in_green = false

func _ready():
	call_deferred("_refresh")

func _refresh():
	for child in get_children():
		if child is CollisionPolygon2D:
			polygon.polygon = child.polygon
			polygon.position = child.position
			polygon.color = color
			add_child(polygon)
			return
