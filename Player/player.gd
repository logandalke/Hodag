extends CharacterBody3D

var health = 50

@export var fire_rate = 1.5
@export var clip_size = 6

var vulnerable = true
var can_fire = true
var is_aiming = false
var first_shot = false

@export var ads_aim : Vector3
@export var ads_default : Vector3
const ads_lerp = 20


@export var controller_sensitivity = 5


var aim_position
var speed = 5.0
const jump_velocity = 4.5

var collectable_count = 0
var true_ending = false

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@onready var camera = $Camera3D
@onready var raycast = $Camera3D/RayCast3D
@onready var interactable_raycast = $Camera3D/InteractionRayCast3D
@onready var animation_player = $AnimationPlayer
@onready var gun = $Camera3D/gun
@onready var reticle = $Camera3D/Control/TextureRect
@onready var shot_sound = $AudioStreamPlayer
@onready var empty_sound = $AudioStreamPlayer2
@onready var damage_sound = $AudioStreamPlayer3
@onready var pickup_sound = $AudioStreamPlayer4
@onready var gunsmoke = $Camera3D/gun/Gunsmoke
@onready var smoke_animation_player = $Camera3D/gun/Gunsmoke/AnimationPlayer
@onready var screen_blood = $Camera3D/Control/Blood
@onready var bullet_hole = preload("res://Player/Gun/bullet_hole.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	aim_position = raycast.transform.origin
	gunsmoke.visible = true
	gunsmoke.visible = false

# Sets input 
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * .005)
		camera.rotate_x(-event.relative.y * .005)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-75), deg_to_rad(75))
	# pauses the game
	if event.is_action_pressed("ui_cancel"):
		$PauseMenu.pause()
	
	
func _process(delta):


	if health <= 25:
		screen_blood.visible = true
		if health <= 0:
#		$PauseMenu.pause()
			get_tree().change_scene_to_file("res://Menu/death_ending.tscn")

	aim_random()

	if Input.is_action_just_pressed("attack") and can_fire and not first_shot:
		if clip_size > 0:
			print("fire!")
			clip_size -= 1
			shot_sound.play()
			if not is_aiming:
				animation_player.play("fire")
			elif is_aiming:
				animation_player.play("aim_fire")
			check_hit()
			print(clip_size)
			can_fire = false
			gunsmoke.visible = true
			smoke_animation_player.play("smoke_movement")
			await get_tree().create_timer(fire_rate).timeout
			gunsmoke.visible = false
			can_fire = true
		elif clip_size <= 0:
			empty_sound.play()
	
	if Input.is_action_just_pressed("attack") and first_shot:
		first_shot = false
		gunsmoke.visible = true
		gunsmoke.visible = false
		pass

	if Input.is_action_pressed("aim") and not animation_player.current_animation == "aim_fire" and not animation_player.current_animation == "fire":
		speed = 1
		animation_player.stop()
		raycast.position = Vector3(0 , 0 , 0)
		gun.transform.origin = gun.transform.origin.lerp(ads_aim, ads_lerp * delta)
		gun.rotation = Vector3(0, deg_to_rad(-90), 0)
		reticle.visible = false
		is_aiming = true

	if Input.is_action_just_released("aim"):
		animation_player.play_backwards("aim")
		speed = 5.0
		reticle.visible = true
		is_aiming = false
	
	if Input.is_action_just_pressed("interact"):
		if interactable_raycast.is_colliding():
			var collider = interactable_raycast.get_collider()
			if collider.is_in_group("interactable"):
				print("Interaction success")
				collider.get_parent().queue_free()
				collectable_count += 1
				pickup_sound.play()
			if collider.is_in_group("true_ending"):
				print("True ending success")
				collider.get_parent().queue_free()
				true_ending = true
				pickup_sound.play()
			if collider.is_in_group("goal"):
				if collectable_count == 3:
					if true_ending == true:
						health = 9999
						get_tree().change_scene_to_file("res://Menu/good_ending.tscn")
						print("good ending")
					else:
						health = 9999
						get_tree().change_scene_to_file("res://Menu/bad_ending.tscn")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	gamepad_handler()
	move_and_slide()

# GAMEPAD MOVEMENT AND LOOK. FIX?
func gamepad_handler():
	var axis_vector = Vector2.ZERO
	axis_vector.x = Input.get_action_strength("look_right") - Input.get_action_strength("look_left")
	axis_vector.y = Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
	if InputEventJoypadMotion:
		rotate_y(deg_to_rad(-axis_vector.x) * controller_sensitivity)
		camera.rotate_x(deg_to_rad(-axis_vector.y) * controller_sensitivity)

func check_hit():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		var hole = bullet_hole.instantiate()
		if collider.is_in_group("enemy"):
			print("enemy hit!")
			collider.damaged()
		if collider.is_in_group("terrain"):
			print("terrain hit!")
			raycast.get_collider().add_child(hole)
			hole.global_transform.origin = raycast.get_collision_point() + (.01 * raycast.get_collision_normal())
			hole.look_at(raycast.get_collision_point() + raycast.get_collision_normal() , Vector3.FORWARD)
		if collider.is_in_group("breakable"):
			#collider.get_parent().add_child(glass)
			collider.get_parent().queue_free()

func aim_random():
	raycast.position = Vector3(randf_range(-0.4 , 0.4) , randf_range(-0.4 , 0.4), 0)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fire":
		animation_player.play("idle")
	if anim_name == "aim":
		animation_player.play("idle")


