extends Area2D

var damage : float = 2

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("player hit")
		body.take_damage(damage)
		queue_free()
