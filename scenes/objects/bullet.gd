class_name Bullet extends Area2D

var direction: int = -1
var speed: int = 2

enum PARENTS {
	player,
	alien
}
var parent: PARENTS

func _physics_process(_delta) -> void:
	global_position.y += direction * speed

func hit(body: Node) -> void:
	if parent == PARENTS.player:
		if body is Alien:
			GameManager.score += 20 + randi_range(0, 20)
			body.queue_free()
			EventBus.update_score.emit()
			
			queue_free()
	elif parent == PARENTS.alien:
		if body is Player:
			body.die()
			queue_free()
	
	if body is Bullet:
		queue_free()
		body.queue_free()
	
	if body.is_in_group("world_collision"):
		queue_free()
