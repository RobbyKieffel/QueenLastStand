class_name CameraTarget
extends Camera2D

var target:Node2D #variabel yang menympan informasi target
var speed = 50.0 #kecepatan camera mengikuti target
var zoom_level = 2 #tingkat zoom dari camera

func _process(delta: float) -> void:
	if target: #jika target tidak null maka posisi dari kamera akan mengikuti target
		global_position = lerp(global_position, target.global_position, speed * delta)
	
	if zoom != Vector2.ONE * zoom_level: #jika atribut zoom pada camera tidak seperi nilai pada variabel zoom_level
		zoom = lerp(zoom, Vector2.ONE * zoom_level, speed * delta) #maka kamera akan zoom sesuai dengan variabel zoom_level
	pass


func shake_camera(intencity:int): #function untuk memberikan efek guncangan pada camera
	for i in 5: #melakukan loop sebanyak 5 kali
		offset = Vector2(randf_range(-intencity, intencity), randf_range(-intencity, intencity)) #mengubah properti offset dengan nilai random sesuai dengan parameter intencity 
		await get_tree().create_timer(0.1, false).timeout #menunggu selama 0.1 detik lalu mengulang lagi kode yang selanjutnya
