extends CharacterBody2D

@export var move_speed = 300.0

func _ready():
	pass

func _physics_process(delta):
	move()
	rotate(get_angle_to(get_global_mouse_position()) + deg_to_rad(90.0))
	move_and_slide()

func move():
	var direction : Vector2
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	direction = direction.normalized()
	if direction:
		velocity = direction * move_speed
	else:
		velocity = Vector2.ZERO
