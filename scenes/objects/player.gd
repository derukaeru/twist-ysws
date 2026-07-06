class_name Player extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer

var can_move: bool = false
var shot: bool = false
const SPEED = 50.0
var bullet_limit: int = 1

func _ready() -> void:
	animation.play_backwards("appear")
	EventBus.start.connect(start)

func _physics_process(_delta) -> void:
	if not can_move: return
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _process(_delta) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	if not Input.is_action_just_pressed("shoot"):
		shot = false

func shoot() -> void:
	if shot or get_tree().get_nodes_in_group("player_bullet").size() >= bullet_limit or not can_move: return
	shot = true
	
	var bullet: Bullet = load(Registry.UID["bullet"]).instantiate()
	Util.add_projectile(bullet)
	
	bullet.global_position = global_position + Vector2(0.0, -10.0)
	bullet.parent = bullet.PARENTS.player
	bullet.add_to_group("player_bullet")
	
	if animation.is_playing():
		await animation.animation_finished
	
	animation.play("appear")
	await animation.animation_finished
	animation.play_backwards("appear")

func die() -> void:
	can_move = false
	EventBus.player_died.emit()
	animation.play("die")
	await animation.animation_finished
	
	GameManager.reset()

func start() -> void:
	can_move = true
	shot = false
