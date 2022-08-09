extends GridContainer

func _ready():
	GameManager.player_initialized.connect(_on_player_initialized)

func _on_player_initialized(player):
	player.inventory.inventory_changed.connect(_on_player_inventory_changed)

func _on_player_inventory_changed(inventory):
	for node in get_children():
		node.queue_free()
	
	for item in inventory.get_items():
		var item_label = Label.new()
		item_label.text = "%s x%d" % [item.item_reference.name, item.quantity]
		add_child(item_label)
