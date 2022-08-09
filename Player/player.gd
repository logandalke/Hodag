extends CharacterBody3D

# Stats
#var level = 0
#var experience = 0
var health = 50
#var magic = 0
#var strength = 0
#var dexterity = 0
var defense = 15
#var agility = 0
#var arcane = 0
#var spirit = 0

@export var controller_sensitivity = 5

const speed = 5.0
const jump_velocity = 4.5

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Array to contain enemies hit by weapon, prevents multiple hits per swing
var enemies_damaged = []

@onready var camera = $Camera3D
@onready var anim_player = $Camera3D/WeaponPivot/AnimationPlayer
@onready var anim_player2 = $Camera3D/Weapon2Pivot/AnimationPlayer2
@onready var hitbox = $Camera3D/WeaponPivot/WeaponMesh/Hitbox
@onready var projectile_spawn = $Camera3D/Weapon2Pivot/ProjectileSpawn
@onready var projectile = preload("res://Spells/projectile.tscn")

# Reference to inventory script, creates a new instance of the script on the player
var inventory_resource = load("res://Player/inventory.gd")
var inventory = inventory_resource.new()




# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Sets input 
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * .005)
		camera.rotate_x(-event.relative.y * .005)
		camera.rotation.x = clamp(camera.rotation.x, deg2rad(-75), deg2rad(75))
	# pauses the game
	if event.is_action_pressed("ui_cancel"):
		$PauseMenu.pause()
	
func _process(delta):
	# Quit with escape key
#	if Input.is_action_just_pressed("quit"):
#		get_tree().quit()
	# Launches attack animation
	if Input.is_action_just_pressed("attack") and anim_player.get_current_animation() != "attack":
		anim_player.play("attack")
		hitbox.monitoring = true
	
	# Launches projectile attack FIX
	if Input.is_action_just_pressed("attack2") and anim_player2.get_current_animation() != "attack2":
		anim_player2.play("attack2")
		var projectile_instance = projectile.instantiate()
		projectile_spawn.add_child(projectile_instance)
		projectile_instance.shoot = true
		
	if health <= 0:
		$PauseMenu.pause()

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
		rotate_y(deg2rad(-axis_vector.x) * controller_sensitivity)
		camera.rotate_x(deg2rad(-axis_vector.y) * controller_sensitivity)

#OPEN EQUIP MENU. RETURN TO THIS. PUT OPEN EQUIP IN PROCESS
#func open_equipment():
#	if Input.is_action_just_pressed("menu"):
#		$EquipmentMenu.open()

## Handles attack collision and damage - OLD AREA DETECTION
#func _on_hitbox_area_entered(enemy):
#	if enemy.is_in_group("enemy") and enemy not in enemies_damaged:
#		print("enemy hit!")
#		enemy.health -= 20
#		enemies_damaged.append(enemy)
#		print(enemies_damaged)

# Handles attack collision and damage
func _on_hitbox_body_entered(enemy):
	if enemy.is_in_group("enemy") and enemy not in enemies_damaged:
		print("enemy hit!")
		enemy.health -= 20
		enemies_damaged.append(enemy)
		print(enemies_damaged)

# Finishes attack animation and releases the array
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		anim_player.play("idle")
		hitbox.monitoring = false
		enemies_damaged.clear()

func _on_animation_player_2_animation_finished(anim_name2):
	if anim_name2 == "attack2":
		anim_player2.play("idle2")



