extends Resource
class_name Inventory

signal inventory_changed

# LOOK AT SETGET IN GODOT 4. THIS IS PROBABLY THE ERROR
@export var _items = Array():
	get: return _items
	set(_items):
		_items = _items

# Sets inventory and signals that inventory has changed
func set_items(new_items):
	_items = new_items
	emit_signal("inventory_changed", self)

# Return a list of items
func get_items():
	return _items

# Return an individual item
func get_item(index):
	return _items[index]

# Add an item in a quantity
func add_item(item_name, quantity):
	# Ensures that negative numbers are not added
	if quantity <= 0:
		print("Can't add negative number of items")
		return
	
	# Ensures that the item exists in the database
	var item = ItemDatabase.get_item(item_name)
	if not item:
		print("Could not find item")
		return

	# Adds items into the inventory, checking to see if a new stack needs to be made
	var remaining_quantity = quantity
	var max_stack_size = item.max_stack_size if item.stackable else 1
	
	# Loop through inventory to find appropriate stacks
	if item.stackable:
		for i in range(_items.size()):
			if remaining_quantity == 0:
				break
			
			# Reference to current loop item
			var inventory_item = _items[i]
			
			if inventory_item.item_reference.name != item.name:
				continue
			
			# Checking for max stack size, splitting stacks, placing items, 
			# and removing the placements from the original quantity
			if inventory_item.quantity < max_stack_size:
				var original_quantity = inventory_item.quantity
				inventory_item.quantity = min(original_quantity + remaining_quantity, max_stack_size)
				remaining_quantity -= inventory_item.quantity - original_quantity
	
	# After placing items into existing stacks, create a new stack if necessary, for that item
	# Curly bracket = dictionary
	while remaining_quantity > 0:
		var new_item = {
			item_reference = item,
			quantity = min(remaining_quantity, max_stack_size)
		}
		_items.append(new_item)
		remaining_quantity -= new_item.quantity
	
	# Once done, emit signal to inform that then inventory has changed
	emit_signal("inventory_changed", self)
