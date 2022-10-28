#extends CharacterBody3D
#
#@onready var nav_agent = $NavigationAgent3d
#
#var speed = 5
#
#func _physics_process(delta):
#	var current_location = global_transform.origin
#	var next_location = nav_agent.get_next_location()
#	var new_velocity = (next_location - current_location).normalized() * speed
#
#	velocity = new_velocity
#	move_and_slide()
#
#func update_target_location(target_location):
#	nav_agent.set_target_location(target_location)
#
#
#
#func _on_navigation_agent_3d_target_reached():
#	"reached"
#	pass # Replace with function body.

extends CharacterBody3D

@export var target_location:Node3D

@onready var nav_agent = $NavigationAgent3d

var speed = 4

func _process(delta):
	find_target()

func _physics_process(delta):
#	nav_agent.set_target_location(target_location.global_position)

	if nav_agent.is_target_reachable():
		var next_location = nav_agent.get_next_location()
		var direction = global_position.direction_to(next_location)
		global_position += direction * delta * speed
#		velocity = velocity.move_toward(direction * speed, speed)
#		move_and_slide()
		look_at(transform.origin + -direction, Vector3.UP)
	
func find_target():
#	print("finding target...")
#	await get_tree().create_timer(2).timeout
	nav_agent.set_target_location(target_location.global_position)
