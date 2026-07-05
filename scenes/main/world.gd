extends Node2D

@onready var alien_container: Node2D = $alien_container

var change_direction_delay: int = 0
var can_change_direction: bool = true

var alien_direction: int = 1
var alien_speed: int = 10

func _ready() -> void: 
	EventBus.change_direction.connect(change_direction)
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
	
	alien_container.global_position = Vector2(8.0, 8.0)
	can_change_direction = true
	change_direction_delay = 0
	
	alien_direction = 1
	for i in range(GameManager.horizontal_alien_amount):
		for j in range(GameManager.vertical_alien_amount):
			var alien: Alien = load(Registry.UID["alien"]).instantiate()
			alien_container.add_child(alien)
			
			alien.position = Vector2(i * 25, j * 22)

func _process(_delta) -> void:
	alien_container.position.x += alien_direction * alien_speed * _delta
	
	if change_direction_delay:
		change_direction_delay -= 1
		can_change_direction = true

func change_direction() -> void:
	alien_direction = alien_direction * -1
	change_direction_delay = 8
	can_change_direction = false
	
	alien_container.global_position.y += 6
