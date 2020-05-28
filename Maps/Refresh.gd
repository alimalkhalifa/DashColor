extends TileMap
tool

export(bool) var refresh_autotiles = false

func _process(delta):
	if Engine.editor_hint:
		if refresh_autotiles:
			refresh_autotiles = false
			update_bitmask_region()
