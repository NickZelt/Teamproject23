extends Node2D

var state = "2items" # animation name with full shelf
var player_in_area = false

@export var item: InventoryItem
var player = null

@onready var inventory: Inventory = preload("res://scripts/inventory/playerInventory.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# empty shelf with each press on the "E"-key
func _process(delta):
	var key_animation = $e_key_animation
	if 	inventory.slots[inventory.slots.size() - 1].item == null || isItemInInventory():
		# Shelf has 4 items
		if state == "2items":
			$AnimatedSprite2D.play("2items")
			if player_in_area:
				if Input.is_action_just_pressed("interact"):
					playPickUpSound()
					player.collect(item)
					state = "1items"
		# Shelf has 3 items
		elif state == "1items":
			$AnimatedSprite2D.play("1items")
			if player_in_area:
				if Input.is_action_just_pressed("interact"):
					playPickUpSound()
					player.collect(item)
					state = "0items"
		# Shelf has 0 items
		elif state == "0items":
			$AnimatedSprite2D.play("0items")
			key_animation.visible = false # hides key animation when shelf is empty
		
# player is in area of the shelf to pick up items
func _on_pickable_area_body_entered(body):
	var key_animation = $e_key_animation
	if body.has_method("player") and inventory.slots[inventory.slots.size() - 1].item == null || isItemInInventory():
		player_in_area = true
		player = body
		# only show key animation above shelf when something is in the shelf
		if state != "0items":
			key_animation.visible = true
			key_animation.play("key_animation")
			
# player left area to pick items from the shelf
func _on_pickable_area_body_exited(body):
	var key_animation = $e_key_animation
	if body.has_method("player") and inventory.slots[inventory.slots.size() - 1].item == null || isItemInInventory():
		player_in_area = false
		# hide and stop key animation
		key_animation.visible = false
		key_animation.stop()
		
func playPickUpSound():
	$"../../../pickUpItem".play()

func isItemInInventory():
	var inInventory = false
	for slotNumber in range(inventory.slots.size()):
		if inventory.slots[slotNumber].item == item:
			inInventory = true
	return inInventory
