extends Node2D

@onready var hud: HUD = $CanvasLayer/HUD
@onready var camera_target: CameraTarget = $CameraTarget
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_target.target = $BlueFire #membuat kamera akan menargetkan node $BlueFire
	pass


func _on_flash_timer_timeout(): #signal untuk timer yang akan mengatur waktu petir muncul
	hud.flash() #panggil method flash() pada scene HUD
	$FlashTimer.start(randf_range(8.0, 15.0)) #mulai lagi timernya dengan waktu yang antara 8 sampai 15 detik
	pass # Replace with function body.


func _on_dead_zone_body_entered(body):
	get_tree().reload_current_scene() #saat menyentuh ari atau rawah maka ulang kembali scenenya
	pass # Replace with function body.


func blue_fire_on(): #function untuk memmunculkan node $BlueFire
	$BlueFire.show()
