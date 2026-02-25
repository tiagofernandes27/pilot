extends Node2D

@onready var trap : PackedScene = preload("res://scenes/trap.tscn")
@onready var player = $"../Player"
@onready var viewport_size : Vector2

var threshold : float = 20.0

func _ready():
	manageSpawns()

func manageSpawns(spawnerCount = 10):
	viewport_size = get_viewport_rect().size
	var randomNumber = RandomNumberGenerator.new()
	for i in spawnerCount:
		var randomX = randomNumber.randf_range(0, viewport_size.x)
		#while randomX <= player.position.x + threshold or randomX >= player.position.x - threshold :
			#randomX = randomNumber.randf_range(0, viewport_size.x)
		var randomY = randomNumber.randf_range(0, viewport_size.y)
		#while randomY <= player.position.y - threshold or randomY >= player.position.y + threshold :
			#randomY = randomNumber.randf_range(0, viewport_size.y)
		var trap_instance = trap.instantiate()
		trap_instance.position = Vector2(randomX, randomY)
		get_parent().add_child.call_deferred(trap_instance)

	
	
	
