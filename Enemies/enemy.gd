extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var anim_player = $WeaponPivot/AnimationPlayer
@onready var hitbox = $WeaponPivot/WeaponMesh/Hitbox

var enemies_damaged = []

var speed = 2
var health = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		queue_free()

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_location()
	var new_velocity = (next_location - current_location).normalized() * speed

	nav_agent.set_velocity(new_velocity)


func update_target_location(target_location):
	nav_agent.set_target_location(target_location)
	look_at(target_location)



func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, .25)
	move_and_slide()

func _on_navigation_agent_3d_target_reached():
	anim_player.play("enemy_attack")
	hitbox.monitoring = true


func _on_hitbox_body_entered(body):
		if body.is_in_group("player"):
			var damage = 25 - body.defense
			print("player took", damage, "!")
			body.health -= damage
			enemies_damaged.append(body)
			print(enemies_damaged)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "enemy_attack":
		hitbox.monitoring = false
		anim_player.play("enemy_idle")
		enemies_damaged.clear()
