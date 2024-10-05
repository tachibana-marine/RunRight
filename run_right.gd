class_name RunRight
extends Node


@onready var start_game_scene = load("res://start_game.tscn")
@onready var main_scene = load("res://main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var start_game = start_game_scene.instantiate()
	start_game.name = "StartGame"
	start_game.connect("game_start", _on_game_start)
	add_child(start_game)

func _on_game_start():
	$StartGame.queue_free()
	var main = main_scene.instantiate()
	main.name = "Main"
	main.connect("player_died", _on_player_died)
	add_child(main)

func _on_player_died():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
