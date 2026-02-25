extends Control

@onready var player = $"../Player"
@onready var score_label = $score
@onready var health_bar = $health_bar

func _ready():
	setup_health_bar()
	update_health_bar()
	player.connect("health_changed", update_health_bar)
	await get_tree().create_timer(0.1).timeout
	connect_enemy_signals()

func connect_enemy_signals():
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.connect("score_changed", update_score_label)
	

func update_score_label():
	score_label.text = str(GlobalsVariables.score)

func setup_health_bar():
	health_bar.min_value = 0
	health_bar.max_value = player.max_health
	health_bar.value = player.health

func update_health_bar():
	health_bar.value = player.health
