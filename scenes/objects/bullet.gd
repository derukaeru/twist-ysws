class_name Bullet extends Area2D

var direction: int = -1
var speed: int = 2

func _physics_process(_delta) -> void:
	global_position.y += direction * speed

func hit(body):
	if body is Alien:
		body.queue_free()
		GameManager.score += 100 + (int(global_position.y) * 10)
	elif body is Player:
		body.die()
	
	queue_free()
