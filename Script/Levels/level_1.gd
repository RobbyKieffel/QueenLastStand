extends Node2D

var random = RandomNumberGenerator.new()
@onready var hud: HUD = $CanvasLayer/HUD

var camera:CameraTarget
var player:Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	player = get_tree().get_nodes_in_group("player")[0]
	camera = get_tree().get_nodes_in_group("Camera")[0]
	camera.target = player
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($TileMap.local_to_map(get_global_mouse_position()))
	#if Input.is_action_just_pressed("mouseClick"):
		#$TileMap.set_cell(0,$TileMap.local_to_map(get_local_mouse_position()), 0,
		#Vector2i(2,1), )
	#print($TileMap.get_cell_source_id(0, $TileMap.local_to_map(get_local_mouse_position())))
	pass


func _on_flash_timer_timeout():
	hud.flash()
	$FlashTimer.start(randf_range(8.0, 15.0))
	pass # Replace with function body.


func _on_dead_zone_body_entered(body):
	get_tree().reload_current_scene()
	pass # Replace with function body.
