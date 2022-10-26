extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3d

var speed = 5

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_location()
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = new_velocity
	move_and_slide()

func update_target_location(target_location):
	nav_agent.set_target_location(target_location)



func _on_navigation_agent_3d_target_reached():
	"reached"
	pass # Replace with function body.
