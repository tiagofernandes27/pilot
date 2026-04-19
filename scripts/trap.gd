extends Area2D

signal score_changed

@onready var health_bar = $health_bar

var health : float = 3
var damage : float = 2

var power_up = load("res://scenes/power_up.tscn").instantiate()
var power_up_chance = 20

func _ready():
	if !is_in_group("enemy"):
		add_to_group("enemy")
	health_bar.max_value = health
	health_bar.min_value = 0
	update_health_bar()
	power_up.setup()

func _on_body_entered(body):
	if body.is_in_group("player_projectile"):
		take_damage(body.damage)
	if body.is_in_group("player"):
		body.take_damage(damage)
		queue_free()

func take_damage(dmg):
	health -= dmg
	update_health_bar()
	if health <= 0:
		GlobalsVariables.score += 1
		spawn_power_up()
		emit_signal("score_changed")
		queue_free()

func update_health_bar():
	health_bar.value = health

func spawn_power_up():
	var random_chance = randi_range(0, 100)
	if random_chance < power_up_chance:
		power_up.position = self.position
		get_tree().current_scene.call_deferred("add_child", power_up)
		power_up.call_deferred("spawn")
		
