extends CharacterBody3D

var health = 50

@export var fire_rate = 1.5
@export var clip_size = 6

var can_fire = true

@export var controller_sensitivity = 5

const speed = 5.0
const jump_velocity = 4.5

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@onready var camera = $Camera3D
@onready var raycast = $Camera3D/RayCast3D





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

	if health <= 0:
		$PauseMenu.pause()
	
	if Input.is_action_just_pressed("attack") and can_fire:
		if clip_size > 0:
			print("fire!")
			clip_size -= 1
			check_hit()
			print(clip_size)
			can_fire = false
			await get_tree().create_timer(fire_rate).timeout
			can_fire = true

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

func check_hit():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("enemy"):
			print("enemy hit!")
			collider.queue_free()
