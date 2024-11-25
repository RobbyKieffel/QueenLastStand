extends Control

var is_play = false #variabel yang akan menandahkan bawah permainan sudah di mulai
var camera_target:CameraTarget #variabel untuk menyimpan informasi camera pada scene
var player:Node2D #variabel untuk menyimpan informasi player pada scene

func _ready() -> void:
	camera_target = get_tree().get_nodes_in_group("Camera")[0] #mencari camera pada scene dengan menggunkan group
	camera_target.speed = 0.3 #mengatur speed dari camera
	player = get_tree().get_nodes_in_group("player")[0]  #mencari player pada scene dengan menggunkan group

func _input(event: InputEvent) -> void:
	if event is InputEventKey and not is_play: #kondisi yang akan dijalankan saat pemain menekan tombol pada keyboard untuk pertama kali
		is_play = true
		$AnimationPlayer.play("Fade") #memainkan animasi false
		camera_target.zoom_level = 1 #mengatur level zoom pada camera
		$Timer.start(4) #memulai timer selama 4 detik


func _on_timer_timeout() -> void: #signal untuk node timer
	if camera_target.target != player: #kondisi saat target dari camera bukan player
		camera_target.target = player #mengubah target camera ke player
		get_tree().get_nodes_in_group("Level")[0].blue_fire_on() #memanggil method blue_fire_on pada scene level untuk menghidupkan blue fire
		$Timer.start(8) #memulai timer lagi selama 8n detik
	else:
		get_tree().get_nodes_in_group("HUD")[0].show_hud() #memanggil method show_hud() untuk menampilkan informasi player pada scene HUD
		get_tree().get_nodes_in_group("player")[0].set_ready_to_move(true) #memanggil method set_ready_to_move() untuk membuat player siap bergerak pada scene player
		camera_target.speed = 40 #mengatur speed dari camera
	pass # Replace with function body.
