extends Control


@onready var credits_roll = $CreditsRoll

var scroll_speed = .5

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$ScreenFadeOut.transition_clear()
	await get_tree().create_timer(1.5).timeout
	$ScreenFadeOut.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if credits_roll.position.y > -1055:
		credits_roll.position.y -= scroll_speed
	
	if Input.is_action_just_pressed("attack") or Input.is_action_just_pressed("jump"):
		if credits_roll.position.y <= -1055:
			$ScreenFade.transition()
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_file("res://Menu/main_menu.tscn")
		elif credits_roll.position.y > -1055:
			scroll_speed = 5
