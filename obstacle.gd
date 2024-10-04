class_name Obstacle
extends AnimatableBody2D

@export var height = 100
@export var width = 20
@export var time_to_cross_screen = 1

var collision_shape = RectangleShape2D.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_height(randi() % 400)
	set_width(randi_range(30, 60))
	$CollisionShape2D.shape = collision_shape
	var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(self, "position:x", -50, time_to_cross_screen)
	tween.tween_callback(queue_free)

func set_height(set_to: int):
	height = set_to
	adjust_height()

func adjust_height():
	$Sprite2D.scale.y = height
	$Sprite2D.position.y = -height / 2.0
	collision_shape.size.y = height
	$CollisionShape2D.position.y = -height / 2.0


func set_width(set_to: int):
	width = set_to
	adjust_width()

func adjust_width():
	$Sprite2D.scale.x = width
	$Sprite2D.position.x = -width / 2.0
	collision_shape.size.x = width
	$CollisionShape2D.position.x = -width / 2.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
