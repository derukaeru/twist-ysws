extends Node

func get_main() -> Node3D:
	return get_tree().current_scene

func pause() -> void:
	get_tree().paused = false
	GameManager.pause_screen.hide()

func unpause() -> void:
	get_tree().paused = true
	GameManager.pause_screen.show()
	
func add_projectile(bullet: Bullet) -> void:
	var container: Node2D = get_tree().get_first_node_in_group("projectile_container")
	if not container: return
	
	container.add_child(bullet)
