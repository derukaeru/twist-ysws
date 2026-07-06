class_name Alien extends CharacterBody2D

var index: int = -1

func _ready() -> void:
	EventBus.alien_shoot.connect(shoot)

func shoot(i: int) -> void:
	if i != index: return
	
	var bullet_instance: Bullet = load(Registry.UID["bullet"]).instantiate()
	Util.add_projectile(bullet_instance)
	bullet_instance.parent = bullet_instance.PARENTS.alien
