extends CharacterBody2D


const SPEED = 200.0 #kecepatan pergerakan player
const JUMP_VELOCITY = -400.0 #kekuatan lompatan player

var hud:HUD #variabel yang akan menyimpan scene node HUD dengan class HUD

var gravity = 1000 #kekuatan gravitasi
var healt := 5 #menyimpan jumlah healt yang dimiliki player
var coin := 0 #menimpan jumlah koin yg didapat player
var attack_demage := 2 #demage dari player

@onready var player_srite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurt_particle: GPUParticles2D = $HurtParticle
@onready var demage_area: Area2D = $AnimatedSprite2D/DemageArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var ready_to_move = false

func _ready():
	hud = get_tree().get_nodes_in_group("HUD")[0] #Mengambil scene HUD yang ada dari menggunakan grub HUD
	hud.call_deferred("set_healt_value", healt) #Mengatur tampilan healt pada HUD sesuai dengan nilai pada variabel Healt
	pass


func _physics_process(delta):
	var direction
	if ready_to_move: direction = Input.get_axis("left_p1", "right_p1") #mengambil nilai dari hasil input player
	
	if Input.is_action_just_pressed("attack_p1") and ready_to_move:
		animation_player.play("Attack1")
		direction = Vector2.ZERO
	
	if not player_srite.animation == "Attack1":
		if direction: #mengecek apakah player memberikan input untuk bergerak
			if direction != 0 : player_srite.scale.x = int(direction)
			#if direction > 0: player_srite.flip_h = false #mengatur arah sprite sesuai dengan hasil input player
			#elif direction < 0: player_srite.flip_h = true
			velocity.x = direction * SPEED #membuat player bergerak sesuai dengan arah yang di-input
		else:
			velocity.x = 0 #Menghentikan pergerakn player secara perlahan
		
		if not is_on_floor(): #mengecek apakah sedang tidak berada di lantai
			velocity.y += gravity * delta #memberikan gravitasi kepada player
			if not player_srite.animation == "Jump": player_srite.play("Fall") #memainkan animasi fall saat terjatuh
		else:
			if direction: player_srite.play("Move") #Memberikan animasi bergerak saat player  memberikan input untuk bergerak
			else:player_srite.play("Idle") #Memberikan animasi Idle saat tidak ada input untuk bergerak
			
			# Handle jump.
			if Input.is_action_just_pressed("jump_p1"): #mengecek input lompat dari player
				player_srite.play("Jump") #Memainkan animasi melompat
				velocity.y = JUMP_VELOCITY #Memberikan dorogan ke pada player untuk melompat
	
	move_and_slide() #membuat player bergerak sesuai dengan perhutungan physycs


func hurt(): #Function untuk membuat player terluka
	hurt_particle.emitting = true #memancarkan partikel darah saat terluka
	healt -= 1 #mengurangi healt player
	player_srite.material.set("shader_parameter/active", true) #mengubah warna sprite menjadi putuh
	await get_tree().create_timer(0.2).timeout #memberi jeda selama 0.2 detik
	player_srite.material.set("shader_parameter/active", false) #mengembalikan warna sprite
	hud.set_healt_value(healt) #memanggil method set_healt_value pada scene HUD
	if healt <= 0: get_tree().reload_current_scene() #Mengulang kembali scene saat healt player sudah habis


func deals_demage():
	for i in demage_area.get_overlapping_bodies():
		i.hurt(attack_demage)


func collet_coin(): #finction untuk menambahkan koin
	coin += 1 #menambahkan coin
	hud.set_coin_value(coin) #memanggil method set_coin_value pada scene HUD
	pass


func _on_animated_sprite_2d_animation_finished(): #function untuk menerima signal dari node animated_sprite_2d setiap kali animasi selesai
	if player_srite.animation == "Jump": player_srite.play("Fall") #memainkan animasi fall setelah selesai memainkan animasi Jump
	if player_srite.animation == "Attack1": #saat animasi attack selesai maka mainkan animasi idle
		player_srite.play("Idle")
	pass

func set_ready_to_move(value:bool): #mengatur variabel ready_to_move sebagai pertanda bawah player sudah bisa digerakan
	ready_to_move = value
