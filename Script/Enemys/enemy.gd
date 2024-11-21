extends CharacterBody2D


@onready var demage_area = $DemageArea
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var allert_sprite: Sprite2D = $AllertSprite

const SPEED = 150.0

var player:Node2D

var dir = Vector2.ZERO #menyimpan arah informasi arah pergerakan
var chase = true #untuk mengatur musuh mengejar dan tdk mengejar player

var healt := 5 #menyimpan jumlah healt yang dimiliki player

func _ready():
	#player = get_tree().get_nodes_in_group("player")[0]
	pass


func _physics_process(delta):
	if not player: return
	dir = (player.global_position - global_position).normalized()
	if global_position.distance_to(player.global_position) > 13:
		velocity = dir * SPEED
	else:
		chase = false
		$AnimatedSprite2D.play("Attack")
		allert_sprite.show()
		velocity = Vector2.ZERO
	
	if dir.x < 0 : $AnimatedSprite2D.flip_h = true
	elif dir.x > 0 : $AnimatedSprite2D.flip_h = false
	
	if chase:
		move_and_slide()


func hurt(demage_takken):
	healt -= demage_takken
	print("Enemy healt = ", healt)
	if healt <= 0: queue_free()


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Attack":
		$AnimatedSprite2D.play("Idle")
		chase = true
		allert_sprite.hide()
	pass # Replace with function body.



func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.animation == "Attack":
		if $AnimatedSprite2D.frame == 3 or $AnimatedSprite2D.frame == 10:
			if not $DemageArea.get_overlapping_bodies().is_empty():
				$DemageArea.get_overlapping_bodies()[0].hurt()
	pass # Replace with function body.


func _on_player_detector_body_entered(body: Node2D) -> void:
	player = body
	pass # Replace with function body.


func _on_player_detector_body_exited(body: Node2D) -> void:
	player = null
	pass # Replace with function body.
