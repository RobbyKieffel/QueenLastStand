extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var hud:HUD

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1000

var healt := 5


func _ready():
	hud = get_tree().get_nodes_in_group("HUD")[0]
	hud.call_deferred("set_healt_value", healt)
	print(healt)
	pass


func _physics_process(delta):
	# Add the gravity.
	var direction = Input.get_axis("left_p1", "right_p1")
	if direction:
		if direction > 0: $AnimatedSprite2D.flip_h = false
		elif direction < 0: $AnimatedSprite2D.flip_h = true
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if direction: $AnimatedSprite2D.play("Movement")
		else:$AnimatedSprite2D.play("Idle")
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		
		# Handle jump.
		if Input.is_action_just_pressed("jump_p1"):
			$AnimatedSprite2D.play("Jump")
			velocity.y = JUMP_VELOCITY

	move_and_slide()


func hurt():
	$GPUParticles2D.emitting = true
	healt -= 1
	print("Healt = ", healt)
	if healt <= 0:
		get_tree().reload_current_scene()


func collet_coin():
	hud.increase_coin()
	pass


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Jump":
		if not is_on_floor():
			$AnimatedSprite2D.play("Fall")
		else:
			$AnimatedSprite2D.play("Idle")
	pass # Replace with function body.
