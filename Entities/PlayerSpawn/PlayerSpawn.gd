extends Node2D
class_name PlayerSpawn

export(String, FILE, "*.tscn") var player_path setget set_player_path
onready var player_scn: PackedScene = load(player_path)

func _ready():
	visible = false
	trigger()

func trigger():
	var players := get_tree().get_nodes_in_group("player")
	for n in players.size():
		var player: PlayerBody = players[n]
		player.queue_free()
		
	var player: PlayerBody = player_scn.instance()
	player.position = position
	get_node("/root/World").call_deferred("add_child", player)
		
	player.position = position
	player.velocity = Vector2()

func set_player_path(path):
	player_path = path
	player_scn = load(player_path)
