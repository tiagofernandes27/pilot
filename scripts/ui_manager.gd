extends Control

@onready var player = $"../Player"
@onready var label = $Label

func _ready():
	update_health_label()
	player.connect("health_changed", update_health_label)

func update_health_label():
	var hp = player.health
	if hp <= 0:
		label.text = "DEAD"
	else:
		label.text = str(int(hp)) 
