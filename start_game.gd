class_name StartGame
extends CanvasLayer

signal game_start
# Called when the node enters the scene tree for the first time.
func _on_start_game_button_pressed() -> void:
	game_start.emit()
