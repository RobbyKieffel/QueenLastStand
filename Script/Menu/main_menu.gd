extends Control

var is_play = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey and not is_play:
		is_play = true
		$AnimationPlayer.play("Fade")
		get_tree().get_nodes_in_group("HUD")[0].show_hud()

func set_player_ready():
	get_tree().get_nodes_in_group("player")[0].set_ready_to_move(true)
