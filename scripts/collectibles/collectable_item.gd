extends StaticBody2D

@export var item: InventoryItem
var player = null

# collect item from the ground
func _on_interactable_area_body_entered(body):
	if body.has_method("player"):
		$"../../../pickUpItem".play()
		player = body
		player_collect()
		self.queue_free()

# add collected item to inventory
func player_collect():
	player.collect(item)
