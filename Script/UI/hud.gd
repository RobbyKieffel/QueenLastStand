class_name HUD
extends CanvasLayer

var coin = 0

@onready var coin_label = $CoinContainer/CoinLabel
@onready var healt_label = $HealtContainer/HealtLabel


func increase_coin():
	coin += 1
	coin_label.text = str(coin)

func set_healt_value(value:int):
	healt_label.text = str(value)


func flash():
	$AnimationPlayer.play("Flash")
