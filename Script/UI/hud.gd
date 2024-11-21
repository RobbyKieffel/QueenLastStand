class_name HUD
extends Control


@onready var coin_label = $CoinContainer/CoinLabel
@onready var healt_label = $HealtContainer/HealtLabel
var camera:CameraTarget

func _ready() -> void:
	camera = get_tree().get_nodes_in_group("Camera")[0]

func set_coin_value(value):
	coin_label.text = str(value)

func set_healt_value(value:int):
	healt_label.text = str(value)


func flash():
	if camera:
		camera.shake_camera(2)
	$AnimationPlayer.play("Flash")


func show_hud():
	$AnimationPlayer2.play("ShowHUD")
