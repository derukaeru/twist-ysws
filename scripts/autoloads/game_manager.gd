extends Node

@onready var pause_screen = load(Registry.UID["pause_screen"]).instantiate()
var canvas_layer = CanvasLayer.new()

var max_player_lives: int = 2
var player_lives: int = max_player_lives

var score: int = 0
var max_score: int = 0

var horizontal_alien_amount: int = 9
var vertical_alien_amount: int = 4

var alien_shoot_delay: float = 0.6

func _ready() -> void:
	add_child(canvas_layer)
	canvas_layer.layer = 5
	canvas_layer.add_child(pause_screen)
	
	pause_screen.hide()
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_d) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			Util.pause()
		else:
			Util.unpause()

func start() -> void:
	EventBus.reset_aliens.emit()
	EventBus.reset_player.emit()
	
	EventBus.start_aliens.emit()
	EventBus.start.emit()

func reset() -> void:
	if player_lives <= 0:
		restart()
		return
	
	player_lives -= 1
	score = 0
	
	start()

func restart() -> void:
	player_lives = 2
	score = 0
	
	EventBus.restart.emit()
