extends CharacterBody2D
var player_in_area = false

@onready var inventory: Inventory = preload("res://scripts/inventory/playerInventory.tres")

var bubble_text = ""
var can_shrink = true
var bubble_text_length = 0
var bubble_text_index = 0
var current_text = ""

@onready var lbltext = get_node("VBoxContainer/Label")
@onready var ninerect = get_node("VBoxContainer/Label/NinePatchRect")
@onready var timer = get_node("Timer")

var do_close = false

func _physics_process(delta):
	var charAnimation = $AnimatedSprite2D
	var key_animation = $e_key_animation
	
	# player ends run
	if player_in_area and Input.is_action_just_pressed("interact"):
		var score = 0
		var random = RandomNumberGenerator.new()
		random.randomize()
		
		charAnimation.play("talk")
		
		# calculate score only when at least one item is in the inventory
		if inventory.slots[0].item != null:
			# calculate score
			score = calculateScore(
				getPlayerInventory()
			)
			
			# dialogue
			talk(
				"Danke fuer deinen Einkauf!\nDein Score: " + str(score)
				)
			
		else:
			# picks a random text
			talk(
				dialogue_picker(
					random.randi_range(1, 20)
				)
			)
	
	# player is not near the cashier
	if !player_in_area:
		charAnimation.play("idle")
		
func _on_pickable_area_body_entered(body):
	var key_animation = $e_key_animation
	# player is in range of cashier
	if body.has_method("player"):
		player_in_area = true
		key_animation.visible = true
		key_animation.play("key_animation")
		
# player is not in range of cashier
func _on_pickable_area_body_exited(body):
	var key_animation = $e_key_animation
	# player is not in range of cashier
	if body.has_method("player"):
		player_in_area = false
		# hide and stop key animation
		key_animation.visible = false
		key_animation.stop()
		
		
func talk(text):
	# clear var
	do_close = false
	can_shrink = true
	bubble_text_length = 0
	bubble_text_index = 0
	current_text = ""
	bubble_text = text
	
	# show speech bubble
	bubble_text_length = bubble_text.length()
	timer.start(1)

func _on_timer_timeout():
	if(!do_close):
		$VBoxContainer.show()
		current_text += bubble_text[bubble_text_index]
		lbltext.text = current_text
		
		if(bubble_text_index < bubble_text_length -1):
			timer.start(0.04)
			bubble_text_index += 1
		else:
			if(!do_close):
				do_close = true
				timer.start(3)
	else:
		if(bubble_text_length < 0):
			current_text.erase(bubble_text_length -1,1)
			lbltext.text = current_text
			bubble_text_length -= 1
			timer.start(0.04)
		else:
			$VBoxContainer.hide()
			
func dialogue_picker(case):
	match case:
			1:
				return "Das Leben ist grausam."
			2:
				return "Aufgeben ist eine Option."
			3:
				return "Alles hat ein Ende,\nnur du bist eine Wurst."
			4:
				return "Dich gibt es nur einmal.\ndas freut die meisten Menschen."
			5:
				return "Bitte...erlöse mich."
			6:
				return "Du bist nicht hässlich, \nnur visuell herausfordernd."
			7:
				return "FICK DIE AFD!!!"
			8:
				return "Dumm. Dümmer. Du."
			9:
				return "Zwei Wörter, ein Finger."
			10:
				return "Brot kann schimmeln,\nwas kannst du?"
			11:
				return "Dank dir weiß ich jetzt\n Stille zu schätzen."
			12:
				return "Du hast irgendwie \ndas gewisse...Nichts."
			13:
				return "Es gibt immer einen\ngrößeren Fisch."
			14:
				return "Dieser Schmerz...\n er hört nicht auf..."
			15:
				return "EXECUTE ORDER 66!!! (<"
			16:
				return "Einmal mit guten Studenten\n einkaufen gehen..."
			17:
				return "........................"
			18:
				return "Hau ab. Du stinkst."
			19:
				return "Tag 2736757...und ich\nstehe noch immer am selben fleck."
			20:
				return "Sammeln Sie Payback Punkte?"
			100:
				return "Endlich bist du fertig..."
			101:
				return "Biep...Bop...Biep...\nich bin eine Kasse..."
			102:
				return "Endlich bist du fertig..."
			103:
				return "Schlechte Wahl..."
			104:
				return "Willst du mit Karte\n oder Lebenszeit bezahlen?"
			105:
				return "Auf Wiedersehen. Guten Tod."
			_:
				return "Moin!"
			
func getPlayerInventory():
	var playerInventory = {}
	for slot in inventory.slots.size():
		if inventory.slots[slot].item != null:
			playerInventory[str(inventory.slots[slot].item.name)] = inventory.slots[slot].amount
	return playerInventory
	
func calculateScore(playerInv):
	var amount = 0
	var score = 0
	for item in playerInv:
		amount = playerInv[item]
		score += getScorePointsForItem(item, amount)
		
	return score
		
func getScorePointsForItem(item, amount):
	var scorePoints = 0
	match item:
			"cola":
				scorePoints += 1 * amount
			"pizza":
				scorePoints += 2 * amount
			"sushi":
				scorePoints += 2 * amount
			"chips":
				scorePoints += 2 * amount
			"cheese":
				scorePoints += 2 * amount
			"cornflakes":
				scorePoints += 2 * amount
			"cookies":
				scorePoints += 1 * amount
			"brokkoli":
				scorePoints += 3 * amount
			"potato":
				scorePoints += 2 * amount
			"eggs":
				scorePoints += 2 * amount
			"suncreme":
				scorePoints += 5 * amount
			"paperbox":
				scorePoints += 4 * amount
			"duck":
				scorePoints += 1 * amount
			"teddy":
				scorePoints += 1 * amount
			"heilstein":
				scorePoints += 6 * amount
			"book":
				scorePoints += 2 * amount
			"console":
				scorePoints += 6 * amount
			"gitarre":
				scorePoints += 5 * amount
			"flower":
				scorePoints += 10 * amount
			"candle":
				scorePoints += 10 * amount
			"puppe":
				scorePoints += 8 * amount
			"plant":
				scorePoints += 5 * amount
			"toothbrush":
				scorePoints += 7 * amount
			"screwdriver":
				scorePoints += 7 * amount
			"melon":
				scorePoints += 3 * amount
			"milk":
				scorePoints += 20 * amount
			"flour":
				scorePoints += 20 * amount
			"marmelade":
				scorePoints += 50 * amount
			"ketchup":
				scorePoints += 30 * amount
			"mushroom":
				scorePoints += 7 * amount
			"ramen":
				scorePoints += 2 * amount
			"banana":
				scorePoints += 3 * amount
			"aubergine":
				scorePoints += 2 * amount
			"tomate":
				scorePoints += 2 * amount
			"salad":
				scorePoints += 3 * amount
			"waschmittel":
				scorePoints += 15 * amount
			"waterbottle":
				scorePoints += 3 * amount
			"donut":
				scorePoints += 15 * amount
			"bread":
				scorePoints += 15 * amount
			"chilli":
				scorePoints += 100 * amount
			"garlic":
				scorePoints += 100 * amount
			"apple":
				scorePoints += 100 * amount
			"unoReverse":
				scorePoints += 1000 * amount
				
	return scorePoints
