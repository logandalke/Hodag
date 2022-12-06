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
@onready var hitbox = $Hitbox
@onready var hodag_sound1 = $AudioStreamPlayer3D
@onready var hodag_sound2 = $AudioStreamPlayer3D2
@onready var hodag_sound3 = $AudioStreamPlayer3D4
@onready var damage_sound = $AudioStreamPlayer3D3
@onready var audio_timer = $AudioTimer
@onready var spawn_point1 = get_parent().get_node("SpawnPoints").get_child(0).global_position
@onready var spawn_point2 = get_parent().get_node("SpawnPoints").get_child(1).global_position
@onready var spawn_point3 = get_parent().get_node("SpawnPoints").get_child(2).global_position
@onready var spawn_point4 = get_parent().get_node("SpawnPoints").get_child(3).global_position
@onready var spawn_point5 = get_parent().get_node("SpawnPoints").get_child(4).global_position


var sound_array = []
var spawn_points = PackedVector3Array()

var speed = 5
var vulnerable = true
var attacking_audio_okay = true

func _ready():
	spawn_points.append(spawn_point1)
	spawn_points.append(spawn_point2)
	spawn_points.append(spawn_point3)
	spawn_points.append(spawn_point4)
	spawn_points.append(spawn_point5)
	sound_array.append(hodag_sound1)
	sound_array.append(hodag_sound2)
	sound_array.append(hodag_sound3)
	sound_array.append(damage_sound)
	audio_timer.start()
	
func _process(delta):
	find_target()
	stuck_check()
	
	if speed > 3:
		animation_player.play("walk")
#	print(spawn_points)
	

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
#			print(direction)


func find_target():
#	print("finding target...")
#	await get_tree().create_timer(2).timeout
	nav_agent.set_target_location(target_location.global_position)

func stuck_check():
	if vulnerable:
		var check_position = null
		check_position = self.global_position
		await get_tree().create_timer(5.0).timeout
		if check_position == self.global_position:
			print("stuck")
			var new_spawn = spawn_points[randi_range(0,4)]
			global_position = new_spawn
			speed += 1

func _on_navigation_agent_3d_target_reached():
	if vulnerable == true:
		speed = 3
		animation_player.play("attack")
		if attacking_audio_okay == true:
			var audio = randi_range(0,3)
			var rand_sound = sound_array[audio]
			rand_sound.play()
			attacking_audio_okay = false

func damaged():
	if vulnerable == true:
		vulnerable = false
		collision.disabled = true
		speed = 0
		damage_sound.play()
	#	animation_player.stop()
		animation_player.play("hit")
		await get_tree().create_timer(6).timeout
		animation_player.play_backwards("hit")
		await get_tree().create_timer(1).timeout
		vulnerable = true
		collision.disabled = false
		speed = 5

func hodag_cries():
	if vulnerable:
		var audio = randi_range(0,2)
		var rand_sound = sound_array[audio]
		rand_sound.play()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		for body in hitbox.get_overlapping_bodies():
			if body.is_in_group("player") and body.vulnerable == true:
				body.health -= 25
				body.damage_sound.play()
				body.vulnerable = false
				await get_tree().create_timer(3).timeout
				body.vulnerable = true
		speed = 5
		attacking_audio_okay = true
	pass # Replace with function body.




func _on_audio_timer_timeout():
	hodag_cries()
	audio_timer.start()
	pass # Replace with function body.
