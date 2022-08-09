extends Node

# Manager getting access to player. Other aspects of the game (UI, etc)
# can subscribe to this signal to get this info once the player has been initialized
signal player_initialized

var player

# Gets reference to player
func _process(delta):
	if not player:
		initialize_player()
		return

# Initializes player, finds player node in the scene tree
func initialize_player():
	player = get_tree().get_root().get_node("/root/World/Player")
	if not player:
		return
	
	# Emits the signal that the player has been initialized and player variable is ready
	emit_signal("player_initialized", player)
	
	# Connects to player inventory "inventory_changed" signal
	player.inventory.inventory_changed.connect(_on_player_inventory_changed)
	
	# Attempts to load an existing inventory from the user's files
	# If an existing inventory file is found, GET the items from it and SET them to the current
	# If no inventory found, gives 3 health potions as default inventory 
	var existing_inventory = load("user://inventory.tres")
	if existing_inventory:
		player.inventory.set_items(existing_inventory.get_items())
	else:
		# Give player 3 health potions?????
		player.inventory.add_item("Health Potion", 3)
	
# Function to save the current copy of the inventory to the system
func _on_player_inventory_changed(inventory):
	ResourceSaver.save("user://inventory.tres", inventory)
