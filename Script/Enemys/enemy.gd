extends CharacterBody2D


@onready var demage_area = $DemageArea
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var allert_sprite: Sprite2D = $AllertSprite

const SPEED = 150.0

var player:Node2D

var dir = Vector2.ZERO #menyimpan arah informasi arah pergerakan
var chase = true #untuk mengatur musuh mengejar dan tdk mengejar player

var healt := 5 #menyimpan jumlah healt yang dimiliki enemy

func _ready():
	pass


func _physics_process(delta):
	if not player: return #jika player tidak terdeteksi maka kode berikutnya tidak akan dijalankan
	dir = (player.global_position - global_position).normalized() #mengambil arah player
	if global_position.distance_to(player.global_position) > 13: #jika jarak musuh dan player lebih besar dari 13 pixel maka musuh akan mengejar player
		velocity = dir * SPEED
	else: #jika lebih kecil dari itu maka akan menghentikan pergerakan musuh lalu menyerang player
		chase = false
		$AnimatedSprite2D.play("Attack") #memainkan animasi attack
		allert_sprite.show() #memunculkan tanda peringatan di kepala musuh
		velocity = Vector2.ZERO #menghentikan pergerakan musuh
	
	#mengatur arah sprite sesuai dengan arah pergerakan player
	if dir.x < 0 : $AnimatedSprite2D.flip_h = true
	elif dir.x > 0 : $AnimatedSprite2D.flip_h = false
	
	if chase: #musuh hanya akan emngejar jika variabel chase bernilai true
		move_and_slide()


func hurt(demage_takken):
	healt -= demage_takken #mengurang healt player
	animated_sprite_2d.material.set("shader_parameter/active", true) #mengubah warna sprite menjadi putuh
	await get_tree().create_timer(0.2).timeout #menbuat jeda selama 0.2 detik
	animated_sprite_2d.material.set("shader_parameter/active", false) #mengembalikan warna sprite seperti semula
	if healt <= 0: queue_free() #menghulangkan musuh saaat healt musuh 0


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Attack": #Mengembalikan animasi ke idle saat animasi attack selesai
		$AnimatedSprite2D.play("Idle")
		chase = true # membuat musuh mengejar player
		allert_sprite.hide()
	pass # Replace with function body.



func _on_animated_sprite_2d_frame_changed(): #signal dari node animated_sprite yang akan diterima selama frame pada sprite berganti
	if $AnimatedSprite2D.animation == "Attack":
		if $AnimatedSprite2D.frame == 3 or $AnimatedSprite2D.frame == 10: #memberikan demage pada musuh di area saaat memainkan animasi Attack dan berada di frame ke-3 dan 10
			if not $DemageArea.get_overlapping_bodies().is_empty():
				$DemageArea.get_overlapping_bodies()[0].hurt() #memberikan demage kepada siapa saja yang ada pada jangkauan serangan
	pass # Replace with function body.


func _on_player_detector_body_entered(body: Node2D) -> void: #signal dari node player_detector yang akan terima setiap kali player menyentuh area detector tersebut 
	player = body #menginilisiali sasi variabel saat player menyentuh area detector
	pass # Replace with function body.


func _on_player_detector_body_exited(body: Node2D) -> void: #signal dari node player_detector yang akan terima setiap kali player keliar area detector tersebut 
	player = null #menghilangkan nilai yang disimpan pada variabel player saat player keluar dari area detector
	pass # Replace with function body.
