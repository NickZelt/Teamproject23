extends Control

@onready var inventory: Inventory = preload("res://scripts/inventory/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

# update Inventory
func _ready():
	inventory.update.connect(update_slots)
	update_slots()
	close()

# update slots in the inventory
func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

# hide / show inventory when the "i"-key is pressed
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()
		
# open inventory / show inventory ui
func open():
	self.visible = true
	is_open = true
	
# close inventory / hide inventory ui
func close():
	self.visible = false
	is_open = false
