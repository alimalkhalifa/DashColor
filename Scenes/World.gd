extends Node2D

export(Array, String, FILE, "*.tscn") var map_paths

export var map_index = 0
var map: Node

func on_finished():
	print("Victory!")
	var players = get_tree().get_nodes_in_group("player")
	for i in players.size():
		var player = players[i]
		player.queue_free()
	map_index += 1
	if map_index < map_paths.size():
		map_load()

func _process(_delta):
	if Input.is_action_just_pressed("command_reset"):
		reset_player()

func reset_player():
	var spawns := get_tree().get_nodes_in_group("spawn")
	if spawns.size() > 0:
		var spawn: PlayerSpawn = spawns[0]
		spawn.trigger()

func _ready():
	map_load()

func map_load():
	if map != null and weakref(map).reference():
		map.queue_free()
	map = load(map_paths[map_index]).instance()
	call_deferred("add_child", map)
