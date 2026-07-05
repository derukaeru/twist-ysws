extends Node

func get_main() -> Node3D:
	return get_tree().current_scene

func pause() -> void:
	get_tree().paused = false
	GameManager.pause_screen.hide()

func unpause() -> void:
	get_tree().paused = true
	GameManager.pause_screen.show()
	
