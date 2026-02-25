extends CharacterBody2D

@onready var timer = $Timer

@export var speed : float = 500.0
var direction : float
var lifeTime : float = 4.0
var damage : float = 1.0
var spawnPos : Vector2

func _ready():
	add_to_group("player_projectile")
	global_position = spawnPos
	global_rotation = direction
	timer.start(lifeTime)

func _physics_process(delta):
	velocity = Vector2(0, -speed).rotated(direction)
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision != null:
			queue_free()

func _on_timer_timeout():
	queue_free()
