extends CharacterBody2D

signal health_changed

@export var move_speed = 300.0
@export var cooldown = 2.0
@onready var projectile : PackedScene = preload("res://scenes/projectile.tscn")
@onready var marker = $Marker2D

var direction : Vector2

var max_health : float = 10.0
var health : float = max_health

var can_shoot = true

func _ready():
	health = max_health
	pass

func _physics_process(delta):
	move()
	rotate(get_angle_to(get_global_mouse_position()) + deg_to_rad(90.0))
	if Input.is_action_pressed("shoot"):
		shoot()
	move_and_slide()

func detect_collisions():
	pass

func shoot():
	if can_shoot:
		var bullet = projectile.instantiate()
		bullet.spawnPos = marker.global_position
		bullet.direction = marker.global_rotation
		get_parent().add_child(bullet)
		can_shoot = false
		await get_tree().create_timer(cooldown).timeout
		can_shoot = true

func move():
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	direction = direction.normalized()
	if direction:
		velocity = direction * move_speed
	else:
		velocity = Vector2.ZERO

func take_damage(damage = 0.0):
	health -= damage
	emit_signal("health_changed")
	if health <= 0:
		queue_free()
