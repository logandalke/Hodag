extends Control

const game = preload("res://EnviroFinal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	preload("res://EnviroFinal.tscn")
	$ScreenFadeOut.transition_clear()
	await get_tree().create_timer(1.5).timeout
	$ScreenFadeOut.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack") or Input.is_action_just_pressed("jump"):
		$ScreenFade.transition()
		get_tree().change_scene_to_packed(game)
	pass
