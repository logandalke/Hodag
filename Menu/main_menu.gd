extends Node3D

const game = preload("res://EnviroFinal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack") or Input.is_action_just_pressed("jump"):
		$ScreenFade.transition()
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://EnviroFinal.tscn")
	pass
