extends Node3D

var shoot = false
var speed = 20
var damage = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shoot:
		global_translate(transform.basis.z.normalized() * speed * delta)

# Handles attack collision and damage - OLD AREA DETECTION
#func _on_hitbox_area_entered(enemy):
#	if enemy.is_in_group("enemy") and not enemy.is_in_group("player"):
#		enemy.health -= damage
#		queue_free()
#	else:
#		queue_free()


func _on_hitbox_body_entered(enemy):
	if enemy.is_in_group("enemy") and not enemy.is_in_group("spell_ignore"):
		enemy.health -= damage
		queue_free()
#	else:
#		queue_free()
