extends Node3D

@onready var broken_glass = $brokenglass/CpuParticles3d
@onready var broken_glass2 = $brokenglass2/CpuParticles3d
@onready var broken_glass_sound = $brokenglass/AudioStreamPlayer3D
@onready var broken_glass_sound2 = $brokenglass2/AudioStreamPlayer3D


func _on_static_body_3d_tree_exited():
	broken_glass.emitting = true
	broken_glass_sound.play()



func _on_static_body_3d_2_tree_exited():
	broken_glass2.emitting = true
	broken_glass_sound2.play()

