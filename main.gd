extends Node2D

var obstacle_scene = preload("res://obstacle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (randi() % 100 == 0):
		var obstacle = obstacle_scene.instantiate()
		obstacle.set_height(randi() % 100)
		obstacle.set_width(randi() % 40)
		obstacle.position = $ObstacleMarker.position
		add_child(obstacle)
