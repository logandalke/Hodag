extends Node3D

@onready var broken_glass = $brokenglass/CpuParticles3d
@onready var broken_glass2 = $brokenglass2/CpuParticles3d
@onready var broken_glass3 = $brokenglass3/CpuParticles3d
@onready var broken_glass4 = $brokenglass4/CpuParticles3d
@onready var broken_glass5 = $brokenglass5/CpuParticles3d
@onready var broken_glass6 = $brokenglass6/CpuParticles3d
@onready var broken_glass7 = $brokenglass7/CpuParticles3d
@onready var broken_glass8 = $brokenglass8/CpuParticles3d
@onready var broken_glass9 = $brokenglass9/CpuParticles3d
@onready var broken_glass10 = $brokenglass10/CpuParticles3d
@onready var broken_glass11 = $brokenglass11/CpuParticles3d
@onready var broken_glass12 = $brokenglass12/CpuParticles3d
@onready var broken_glass13 = $brokenglass13/CpuParticles3d
@onready var broken_glass14 = $brokenglass14/CpuParticles3d
@onready var broken_glass15 = $brokenglass15/CpuParticles3d
@onready var broken_glass16 = $brokenglass16/CpuParticles3d
@onready var broken_glass17 = $brokenglass17/CpuParticles3d
@onready var broken_glass18 = $brokenglass18/CpuParticles3d
@onready var broken_glass_sound = $brokenglass/AudioStreamPlayer3D
@onready var broken_glass_sound2 = $brokenglass2/AudioStreamPlayer3D
@onready var broken_glass_sound3 = $brokenglass3/AudioStreamPlayer3D
@onready var broken_glass_sound4 = $brokenglass4/AudioStreamPlayer3D
@onready var broken_glass_sound5 = $brokenglass5/AudioStreamPlayer3D
@onready var broken_glass_sound6 = $brokenglass6/AudioStreamPlayer3D
@onready var broken_glass_sound7 = $brokenglass7/AudioStreamPlayer3D
@onready var broken_glass_sound8 = $brokenglass8/AudioStreamPlayer3D
@onready var broken_glass_sound9 = $brokenglass9/AudioStreamPlayer3D
@onready var broken_glass_sound10 = $brokenglass10/AudioStreamPlayer3D
@onready var broken_glass_sound11 = $brokenglass11/AudioStreamPlayer3D
@onready var broken_glass_sound12 = $brokenglass12/AudioStreamPlayer3D
@onready var broken_glass_sound13 = $brokenglass13/AudioStreamPlayer3D
@onready var broken_glass_sound14 = $brokenglass14/AudioStreamPlayer3D
@onready var broken_glass_sound15 = $brokenglass15/AudioStreamPlayer3D
@onready var broken_glass_sound16 = $brokenglass16/AudioStreamPlayer3D
@onready var broken_glass_sound17 = $brokenglass17/AudioStreamPlayer3D
@onready var broken_glass_sound18 = $brokenglass18/AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_static_body_3d_1_tree_exited():
	broken_glass.emitting = true
	broken_glass_sound.play()
	pass # Replace with function body.


func _on_static_body_3d_2_tree_exited():
	broken_glass2.emitting = true
	broken_glass_sound2.play()
	pass # Replace with function body.


func _on_static_body_3d_3_tree_exited():
	broken_glass3.emitting = true
	broken_glass_sound3.play()
	pass # Replace with function body.


func _on_static_body_3d_4_tree_exited():
	broken_glass4.emitting = true
	broken_glass_sound4.play()
	pass # Replace with function body.


func _on_static_body_3d_5_tree_exited():
	broken_glass5.emitting = true
	broken_glass_sound5.play()
	pass # Replace with function body.


func _on_static_body_3d_6_tree_exited():
	broken_glass6.emitting = true
	broken_glass_sound6.play()
	pass # Replace with function body.


func _on_static_body_3d_7_tree_exited():
	broken_glass7.emitting = true
	broken_glass_sound7.play()
	pass # Replace with function body.


func _on_static_body_3d_8_tree_exited():
	broken_glass8.emitting = true
	broken_glass_sound8.play()
	pass # Replace with function body.


func _on_static_body_3d_9_tree_exited():
	broken_glass9.emitting = true
	broken_glass_sound9.play()
	pass # Replace with function body.


func _on_static_body_3d_10_tree_exited():
	broken_glass10.emitting = true
	broken_glass_sound10.play()
	pass # Replace with function body.


func _on_static_body_3d_11_tree_exited():
	broken_glass11.emitting = true
	broken_glass_sound11.play()
	pass # Replace with function body.


func _on_static_body_3d_12_tree_exited():
	broken_glass12.emitting = true
	broken_glass_sound12.play()
	pass # Replace with function body.


func _on_static_body_3d_13_tree_exited():
	broken_glass13.emitting = true
	broken_glass_sound13.play()
	pass # Replace with function body.


func _on_static_body_3d_14_tree_exited():
	broken_glass14.emitting = true
	broken_glass_sound14.play()
	pass # Replace with function body.


func _on_static_body_3d_15_tree_exited():
	broken_glass15.emitting = true
	broken_glass_sound15.play()
	pass # Replace with function body.


func _on_static_body_3d_16_tree_exited():
	broken_glass16.emitting = true
	broken_glass_sound16.play()
	pass # Replace with function body.


func _on_static_body_3d_17_tree_exited():
	broken_glass17.emitting = true
	broken_glass_sound17.play()
	pass # Replace with function body.


func _on_static_body_3d_18_tree_exited():
	broken_glass18.emitting = true
	broken_glass_sound18.play()
	pass # Replace with function body.

