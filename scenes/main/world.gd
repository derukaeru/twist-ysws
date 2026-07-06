extends Node2D

@onready var alien_container: Node2D = $alien_container

var change_direction_delay: int = 0
var can_change_direction: bool = true

var alien_direction: int = 1
var alien_speed: int = 10

var SCREEN_WIDTH: int = 288

func _ready() -> void:
	reset_aliens()

func reset_player() -> void:
	var player: Player = get_tree().get_first_node_in_group("player")
	if player:
		player.queue_free()
		GameManager.player_lives = GameManager.max_player_lives
	var new_player: Player = load(Registry.UID["player"]).instantiate()
	add_child(new_player)

func remove_aliens() -> void:
	for entry in alien_container.get_children():
		entry.queue_free()

func reset_aliens() -> void:
	remove_aliens()
	
	can_change_direction = true
	change_direction_delay = 0
	
	alien_direction = 1
	for i in range(GameManager.horizontal_alien_amount):
		for j in range(GameManager.vertical_alien_amount):
			var alien: Alien = load(Registry.UID["alien"]).instantiate()
			alien_container.add_child(alien)
			
			alien.position = Vector2(i * 25, j * 22)
			alien.index = i*j + i
	
	var grid_width: float = GameManager.horizontal_alien_amount * 25
	alien_container.global_position = Vector2((float(SCREEN_WIDTH) / 2) - (grid_width / 2), 8.0)

func _process(_delta) -> void:
	alien_container.position.x += alien_direction * alien_speed * _delta
	
	if change_direction_delay:
		change_direction_delay -= 1
		can_change_direction = true

func change_direction(dir: int) -> void:
	if dir: 
		alien_direction = dir
	else:
		alien_direction = alien_direction * -1
	
	EventBus.changeed_direction.emit(alien_direction)
	change_direction_delay = 8
	can_change_direction = false
	
	alien_container.global_position.y += 0.5

func change_dir_left(body: Node) -> void:
	if body is Alien:
		change_direction(1)

func change_dir_right(body: Node) -> void:
	if body is Alien:
		change_direction(-1)
