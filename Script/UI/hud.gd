class_name HUD
extends Control

#Variabel untuk menympan nilai dari child_node
@onready var coin_label = $CoinContainer/CoinLabel
@onready var healt_label = $HealtContainer/HealtLabel
var camera:CameraTarget #untuk menympan informasi scene mode pada scene game

func _ready() -> void:
	camera = get_tree().get_nodes_in_group("Camera")[0] #mencari scene/node camera pada game scene

func set_coin_value(value): #mengubah jumlah coin yang ditampilkan di layar
	coin_label.text = str(value)

func set_healt_value(value:int):  #mengubah jumlah healt yang ditampilkan di layar
	healt_label.text = str(value)


func flash(): #function untuk memainkan animasi petir pada layar
	if camera: #jika terdapat node camera pada sceme
		camera.shake_camera(2) #maka panggil method shake_camera() dengan tingkan intensitas guncangan sebesar 2
	$AnimationPlayer.play("Flash") #mainkan animasi flash/petir pada layar


func show_hud(): #function untuk menampilakn informasi player HUD(Head Up Display) saat game dimulai
	$AnimationPlayer2.play("ShowHUD") #mainkan animasi untuk menampilkan HUD
