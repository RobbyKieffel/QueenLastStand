extends CharacterBody2D


@onready var demage_area = $DemageArea
@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
var a = []
var player:Node2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dir = Vector2.ZERO
var chase = true #untuk mengatur musuh mengejar dan tdk mengejar player

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]


func _physics_process(delta):
	# Add the gravity.
	dir = (player.global_position - global_position).normalized()
	if global_position.distance_to(player.global_position) > 10:
		velocity = dir * SPEED
	else:
		chase = false
		$AnimatedSprite2D.play("Attack")
		velocity = Vector2.ZERO
	
	if dir.x < 0 : $AnimatedSprite2D.flip_h = true
	elif dir.x > 0 : $AnimatedSprite2D.flip_h = false
	
	if chase:
		move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Attack":
		$AnimatedSprite2D.play("Idle")
		chase = true
	pass # Replace with function body.



func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.animation == "Attack":
		if $AnimatedSprite2D.frame == 3 or $AnimatedSprite2D.frame == 10:
			if not $DemageArea.get_overlapping_bodies().is_empty():
				$DemageArea.get_overlapping_bodies()[0].hurt()
	pass # Replace with function body.
