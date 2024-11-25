extends CharacterBody2D

#menyimpan informasi dari child_node pada enemy_slime
@onready var wait_timer: Timer = $WaitTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var watter_particle: GPUParticles2D = $WatterParticle

const SPEED = 300.0 #speed dari slime
const GRAVITY = 1000 #gravitasy dari slime
var direction = -1 #arah pergerakan dari musuh -1 = kiri | 1 = kanan
var last_direction = -1 #menympan arah pergerakan terakhir dari slime

var healt := 5 #menyimpan jumlah healt yang dimiliki slime

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	#Memgubah arah srite musuh sesuai dengan arah pergerakan musuh 
	if direction < 0: animated_sprite.flip_h = false
	elif direction > 0: animated_sprite.flip_h = true
	
	if not is_on_wall(): #jika sedang tidak bersentuhan dengan dinding maka mainkan animasi "Move" dan pancarkan particle air
		animated_sprite.play("Move")
		watter_particle.emitting = true
	else: #jika tidak bersentuhan dengan dinding maka mainkan animasi "Idle" dan berhenti pancarkan particle air lalu mulai timer untuk mengunggu
		watter_particle.emitting = false
		animated_sprite.play("Idle")
		if wait_timer.time_left == 0:
			wait_timer.start()
	
	velocity.x = direction * SPEED #bergerak sesuai dengan arah dari variabel direction
	
	move_and_slide()


func hurt(demage_takken):
	healt -= demage_takken #mengurang healt player
	animated_sprite.material.set("shader_parameter/active", true) #mengubah warna sprite menjadi putuh
	await get_tree().create_timer(0.2).timeout #memberi jeda selama 0.2 detik
	animated_sprite.material.set("shader_parameter/active", false) #mengembalikan warna sprite
	if healt <= 0: queue_free() #menghulangkan musuh saaat healt musuh 0

func _on_wait_timer_timeout() -> void:
	last_direction *= -1
	direction = last_direction
	if direction < 0: watter_particle.rotation_degrees = 0
	elif direction > 0: watter_particle.rotation_degrees = 180
	pass # Replace with function body.


func _on_demage_area_body_entered(body: Node2D) -> void:
	body.hurt()
	pass # Replace with function body.
