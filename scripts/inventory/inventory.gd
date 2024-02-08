extends Resource

class_name Inventory

signal update

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem):
	
	var itemslots = slots.filter(func(slot): return slot.item == item)
	# adds an item which is already in the inventory to the specific slot
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	# add a new item to the next empty slot
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			# set amount to 1, because its the first item
			emptyslots[0].amount = 1
	update.emit()
