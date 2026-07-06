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
			body.queue_free()
			GameManager.score += 100 + (int(global_position.y) * 10)
			
			queue_free()
	elif parent == PARENTS.alien:
		if body is Player:
			body.die()
			queue_free()
	
