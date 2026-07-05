extends Node2D

@onready var alien_container: Node2D = $alien_container

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
	
	for i in range(GameManager.horizontal_alien_amount):
		for j in range(GameManager.vertical_alien_amount):
			var alien: Alien = load(Registry.UID["alien"]).instantiate()
			alien_container.add_child(alien)
			
			alien.position = Vector2(i * 20, j * 22)
