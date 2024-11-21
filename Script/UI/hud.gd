class_name HUD
extends Control


@onready var coin_label = $CoinContainer/CoinLabel
@onready var healt_label = $HealtContainer/HealtLabel


func set_coin_value(value):
	coin_label.text = str(value)

func set_healt_value(value:int):
	healt_label.text = str(value)


func flash():
	$AnimationPlayer.play("Flash")


func show_hud():
	$AnimationPlayer2.play("ShowHUD")
