extends Node
#
#@onready var player = $Player
#
#func _physics_process(delta):
#	get_tree().call_group("enemy", "update_target_location", player.global_transform.origin)

var message_read = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$ScreenFadeOut.transition_clear()
	await get_tree().create_timer(1.5).timeout
	$ScreenFadeOut.queue_free()


func _on_screen_fade_out_child_exiting_tree(node):
	if message_read == false:
		get_tree().create_timer(1).timeout
		get_tree().paused = true
