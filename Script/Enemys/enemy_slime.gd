extends CharacterBody2D

@onready var wait_timer: Timer = $WaitTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var watter_particle: GPUParticles2D = $WatterParticle

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 1000
var direction = -1
var last_direction = -1
var wait_time_finish = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	#if is_on_wall():
			#wait_time_finish = false
		#if not wait_time_finish:
			#direction = 0
	
	if direction < 0: animated_sprite.flip_h = false
	elif direction > 0: animated_sprite.flip_h = true
	
	if not is_on_wall():
		animated_sprite.play("Move")
		watter_particle.emitting = true
	else:
		watter_particle.emitting = false
		animated_sprite.play("Idle")
		if wait_timer.time_left == 0:
			wait_timer.start()
	velocity.x = direction * SPEED
	
	
	move_and_slide()


func _on_wait_timer_timeout() -> void:
	#print("ok")
	last_direction *= -1
	direction = last_direction
	if direction < 0: watter_particle.rotation_degrees = 0
	elif direction > 0: watter_particle.rotation_degrees = 180
	await get_tree().create_timer(1, false).timeout
	wait_time_finish = true
	pass # Replace with function body.


func _on_demage_area_body_entered(body: Node2D) -> void:
	body.hurt()
	pass # Replace with function body.
