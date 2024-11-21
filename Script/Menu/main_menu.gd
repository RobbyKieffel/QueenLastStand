extends Control

var is_play = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event is InputEventKey and not is_play:
		is_play = true
		$AnimationPlayer.play("Fade")
		get_tree().get_nodes_in_group("player")[0].set_ready_to_move(true)
		get_tree().get_nodes_in_group("HUD")[0].show_hud()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
