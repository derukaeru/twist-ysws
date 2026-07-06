class_name Alien extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
var index: int = -1

func _ready() -> void:
	EventBus.alien_shoot.connect(shoot)

func shoot(i: int) -> void:
	if i != index: return
	
	var bullet: Bullet = load(Registry.UID["bullet"]).instantiate()
	Util.add_projectile(bullet)
	
	bullet.global_position = global_position + Vector2(0.0, -10.0)
	bullet.parent = bullet.PARENTS.alien
	bullet.direction = 1
	
