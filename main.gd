class_name Main
extends Node2D

signal player_died

const MAX_HEALTH = 100

var obstacle_scene = preload("res://obstacle.tscn")
var background_bubble = preload("res://background_bubble.tscn")

var screen_size: Vector2
var is_bubble_spawnable: bool = true
var is_game_over: bool = false
var score: int = 0;
var health: int = MAX_HEALTH;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	_start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (is_game_over):
		return
	if (randi() % 100 == 0):
		var obstacle: Obstacle = obstacle_scene.instantiate()
		obstacle.position = $ObstacleMarker.position
		add_child(obstacle)
	if (randi() % 50 == 0 && is_bubble_spawnable):
		var bubble: BackgroundBubble = background_bubble.instantiate()
		bubble.position = Vector2(screen_size.x, randi_range(60, 100))
		print("posx:", bubble.position.x, ", length:", bubble.length)
		add_child(bubble)
		is_bubble_spawnable = false
		get_tree().create_timer(1).connect("timeout", func(): is_bubble_spawnable = true)

func _start_game():
	score = 0
	health = MAX_HEALTH
	_set_score_label()
	_set_health_label()
	$ScoreTimer.start()

func _game_over():
	is_game_over = true
	$ScoreTimer.stop()
	player_died.emit(score)
	$Box.is_dead = true

func _set_score_label():
	$StatusCanvas/ScoreLabel.text = "Score: " + str(score)

func _set_health_label():
	$StatusCanvas/HealthLabel.text = "Health: " + str(health)

func _on_score_timer_timeout() -> void:
	score += 1
	_set_score_label()


func _on_character_body_2d_damage() -> void:
	if (is_game_over):
		return
	health -= 1
	_set_health_label()
	if (health <= 0):
		_game_over()
