class_name Player extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer

var shot: bool = false
const SPEED = 50.0

func _ready() -> void:
	animation.play_backwards("appear")

func _physics_process(_delta) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _process(_delta) -> void:
	if Input.is_action_just_pressed("shoot"):
		animation.play("appear")
		shoot()
	
	if not Input.is_action_just_pressed("shoot"):
		shot = false

func shoot() -> void:
	if shot: return
	shot = true
	
	var bullet: Bullet = load(Registry.UID["bullet"]).instantiate()
	Util.add_projectile(bullet)
	bullet.global_position = global_position + Vector2(0.0, -10.0)
	
	if animation.is_playing():
		await animation.animation_finished
		
	animation.play_backwards("appear")
	# set bullet position and direction

func die():
	pass
