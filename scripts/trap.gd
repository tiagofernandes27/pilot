extends Area2D

signal score_changed

@onready var health_bar = $health_bar

var health : float = 3
var damage : float = 2

func _ready():
	if !is_in_group("enemy"):
		add_to_group("enemy")
	health_bar.max_value = health
	health_bar.min_value = 0
	update_health_bar()

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
		emit_signal("score_changed")
		queue_free()

func update_health_bar():
	health_bar.value = health
