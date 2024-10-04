extends CharacterBody2D

@export var walking_speed: float = 800.0
@export var dash_speed: float = 1600.0
@export var jump_height: float = 450.0
@export var acceleration = 4000
@export var fliction = 1000
@export var gravity: float = 8000.0
@export var wind_acceleration: float = 2000.0

signal damage
var is_outside_camera: bool = false
var is_invincible: bool = false
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (is_outside_camera and not is_invincible):
		damage.emit()
		is_invincible = true
		get_tree().create_timer(0.2).connect("timeout", func(): is_invincible = false)
	if (is_on_floor()):
		velocity.x -= delta * wind_acceleration
		$CPUParticles2D.emitting = true
	else:
		$CPUParticles2D.emitting = false
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
		velocity.x = clamp(velocity.x + dir * acceleration * delta, -horizontal_speed, horizontal_speed)
	else:
		if (velocity.x > 0):
			velocity.x -= fliction * delta
		else:
			velocity.x += fliction * delta


	if (Input.is_action_just_pressed("jump") && is_on_floor()):
		velocity.y = -(pow(2 * gravity * jump_height, 0.5))
		print(velocity.y)
	elif (Input.is_action_just_released("jump")):
		velocity.y = 0


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	is_outside_camera = true


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
		is_outside_camera = false
