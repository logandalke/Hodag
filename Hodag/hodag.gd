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
@onready var animation_player = $AnimationPlayer
@onready var collision = $CollisionShape3d

var speed = 4
var vulnerable = true

func _process(delta):
	find_target()
	
	if speed > 1:
		animation_player.play("walk")

func _physics_process(delta):
#	nav_agent.set_target_location(target_location.global_position)
	if vulnerable == true:
		if nav_agent.is_target_reachable():
			var next_location = nav_agent.get_next_location()
			var direction = global_position.direction_to(next_location)
			global_position += direction * delta * speed
		#		velocity = velocity.move_toward(direction * speed, speed)
		#		move_and_slide()
			look_at(transform.origin - direction, Vector3.UP)
	
func find_target():
#	print("finding target...")
#	await get_tree().create_timer(2).timeout
	nav_agent.set_target_location(target_location.global_position)



func _on_navigation_agent_3d_target_reached():
	if vulnerable == true:
		speed = 1
		animation_player.play("attack")

func damaged():
	if vulnerable == true:
		vulnerable = false
		collision.disabled = true
		speed = 0
	#	animation_player.stop()
		animation_player.play("hit")
		await get_tree().create_timer(4).timeout
		animation_player.play_backwards("hit")
		await get_tree().create_timer(1).timeout
		vulnerable = true
		collision.disabled = false
		speed = 4



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		
		speed = 4
	pass # Replace with function body.
	
