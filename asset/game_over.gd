class_name GameOver
extends CanvasLayer

signal try_again

@export var score: int = 0:
	set(value):
		score = value
		$ScoreLabel.text = "Score: " + str(score)


func _on_try_again_button_pressed() -> void:
	try_again.emit()
