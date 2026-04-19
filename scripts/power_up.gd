extends Node

var heal_texture = preload("res://assets/heal.png")
var shooting_speed_texture = preload("res://assets/shooting_speed.png")
var damage_texture = preload("res://assets/damage.png")

@onready var sprite_2d = $Sprite2D

var type : GlobalsVariables.PowerUpType
var value
var description

var texture

func setup():
	type = random_power_up_type()
	match type:
		GlobalsVariables.PowerUpType.HEAL:
			value = 2.0
		GlobalsVariables.PowerUpType.SHOOTING_SPEED:
			value = 0.8
		GlobalsVariables.PowerUpType.DAMAGE:
			value = 0.5

func spawn():
	match type:
		GlobalsVariables.PowerUpType.HEAL:
			sprite_2d.texture = heal_texture
		GlobalsVariables.PowerUpType.SHOOTING_SPEED:
			sprite_2d.texture = shooting_speed_texture
		GlobalsVariables.PowerUpType.DAMAGE:
			sprite_2d.texture = damage_texture

func random_power_up_type():
	return randi_range(0,  GlobalsVariables.PowerUpType.size()-1)


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.collect_power_up(self)
