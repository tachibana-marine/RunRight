extends Node2D

var obstacle_scene = preload("res://obstacle.tscn")
var background_bubble = preload("res://background_bubble.tscn")

var screen_size: Vector2
var is_bubble_spawnable: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport().size
	print(screen_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (randi() % 100 == 0):
		var obstacle: Obstacle = obstacle_scene.instantiate()
		obstacle.set_height(randi() % 400)
		obstacle.set_width(randi() % 40)
		obstacle.position = $ObstacleMarker.position
		add_child(obstacle)
	if (randi() % 50 == 0 && is_bubble_spawnable):
		var bubble: BackgroundBubble = background_bubble.instantiate()
		bubble.position = Vector2(screen_size.x, randi_range(60, 100))
		print("posx:", bubble.position.x, ", length:", bubble.length)
		add_child(bubble)
		is_bubble_spawnable = false
		get_tree().create_timer(1).connect("timeout", func(): is_bubble_spawnable = true)
