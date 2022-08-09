extends Area3D

func _on_crystal_ball_body_entered(body):
	if body == GameManager.player:
		GameManager.player.inventory.add_item("Crystal Ball", 1)
		queue_free()
