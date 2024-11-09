extends Area2D

func _on_body_entered(body):
	body.collet_coin()
	queue_free()
