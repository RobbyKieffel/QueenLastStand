class_name CameraTarget
extends Camera2D

var target:Node2D
var focus = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		global_position = lerp(global_position, target.global_position, 50 * delta)
	
	#if focus:
#		
	#if Input.is_action_just_pressed("ui_cancel"):
		#shake_camera(2)
	pass


func shake_camera(intencity:int):
	for i in 5:
		offset = Vector2(randf_range(-intencity, intencity), randf_range(-intencity, intencity))
		await get_tree().create_timer(0.1, false).timeout
