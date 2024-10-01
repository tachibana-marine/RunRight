extends CharacterBody2D

@export var walking_speed: float = 400.0
@export var dash_speed: float = 800.0
@export var jump_height: float = 450.0
@export var acceleration = 0.15
@export var fliction = 0.8
@export var gravity: float = 4000.0

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_slide()
	velocity.y += delta * gravity
	var dir = 0
	var horizontal_speed = 0.0
	if (Input.is_action_pressed("move_left")):
		dir = -1
		horizontal_speed = walking_speed
	elif (Input.is_action_pressed("move_right")):
		dir = 1
		horizontal_speed = walking_speed

	if (Input.is_action_pressed("dash_left")):
		dir = -1
		horizontal_speed = dash_speed
	elif (Input.is_action_pressed("dash_right")):
		dir = 1
		horizontal_speed = dash_speed
	if (dir != 0):
		velocity.x = lerp(velocity.x, dir * horizontal_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, fliction)

	if (Input.is_action_just_pressed("jump") && is_on_floor()):
		velocity.y = -(pow(2 * gravity * jump_height, 0.5))
		print(velocity.y)
	elif (Input.is_action_just_released("jump")):
		velocity.y = 0
