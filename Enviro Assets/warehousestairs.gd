extends Node3D

@onready var broken_glass = $brokenglass/CpuParticles3d
@onready var broken_glass2 = $brokenglass2/CpuParticles3d
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_static_body_3d_tree_exited():
	broken_glass.emitting = true
	pass # Replace with function body.


func _on_static_body_3d_2_tree_exited():
	broken_glass2.emitting = true
	pass # Replace with function body.
