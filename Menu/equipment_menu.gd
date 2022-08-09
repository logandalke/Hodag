extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
#@onready var resume_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ResumeButton
#@onready var quit_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton

#func _ready():
#	resume_button.pressed.connect(resume)
#	quit_button.pressed.connect(get_tree().quit)

func resume():
	animator.play("resume")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func open():
	animator.play("pause")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
