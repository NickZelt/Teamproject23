extends StaticBody2D

@export var item: InventoryItem
var player = null

@onready var inventory: Inventory = preload("res://scripts/inventory/playerInventory.tres")

# collect item from the ground
func _on_interactable_area_body_entered(body):
	if body.has_method("player") and inventory.slots[inventory.slots.size() - 1].item == null || isItemInInventory():
		$"../../../pickUpItem".play()
		player = body
		player_collect()
		self.queue_free()

# add collected item to inventory
func player_collect():
	player.collect(item)

func isItemInInventory():
	var inInventory = false
	for slotNumber in range(inventory.slots.size()):
		if inventory.slots[slotNumber].item == item:
			inInventory = true
	return inInventory
