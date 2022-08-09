extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var resume_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ResumeButton
@onready var quit_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton

func _ready():
	resume_button.pressed.connect(resume)
	quit_button.pressed.connect(get_tree().quit)

func resume():
	animator.play("resume")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause():
	animator.play("pause")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
