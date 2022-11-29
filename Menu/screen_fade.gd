extends Control

signal transitioned
signal transition_cleared
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func transition():
	$AnimationPlayer.play("screen_fade_black")
	
func transition_clear():
	$AnimationPlayer.play_backwards("screen_fade_black")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "screen_fade_black":
		emit_signal("transitioned")
	if anim_name == "screen_fade_clear":
		emit_signal("transition_cleared")
	pass # Replace with function body.
