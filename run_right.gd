class_name RunRight
extends Node


@onready var start_game_scene = load("res://start_game.tscn")
@onready var main_scene = load("res://main.tscn")
@onready var game_over_scene = load("res://asset/game_over.tscn")
var start_game: StartGame = null
var main: Main = null
var game_over: GameOver = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game = start_game_scene.instantiate()
	start_game.name = "StartGame"
	start_game.connect("game_start", _on_game_start)
	add_child(start_game)

func _start_game():
	main = main_scene.instantiate()
	main.name = "Main"
	main.connect("player_died", _on_player_died)
	add_child(main)

func _on_game_start():
	start_game.queue_free()
	_start_game()

func _on_player_died(score: int):
	game_over = game_over_scene.instantiate()
	game_over.name = "GameOver"
	game_over.score = score
	add_child(game_over)
	game_over.connect("try_again", _on_try_again)

func _on_try_again():
	main.queue_free()
	game_over.queue_free()
	_start_game()