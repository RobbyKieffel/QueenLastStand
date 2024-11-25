extends Area2D

func _on_body_entered(body):
	body.collet_coin() #memanggil methode collet_coin() pada player yang menyentuhnya
	queue_free() #menghilangkan coin dari scene
