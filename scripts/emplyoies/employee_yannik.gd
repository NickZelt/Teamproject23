extends CharacterBody2D
var player_in_area = false

@export var inventory: Inventory

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
	
	#charAnimation.flip_h = true
	charAnimation.play("idle")
	
	# player ends run
	if player_in_area and Input.is_action_just_pressed("interact"):
		var random = RandomNumberGenerator.new()
		random.randomize()
		
		# picks a random text
		talk(
			dialogue_picker(
				random.randi_range(1, 14)
			)
		)
		
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
				return "Jo, was geht?"
			2:
				return "FÜR DIE DEMOKRATIE!!!"
			3:
				return "Ich bin der Erfinder\ndieser Konsolen..."
			4:
				return "Ich habe gutes Zeug im Lager...\nhast du bock?"
			5:
				return "Die Musik macht mich verückt.\nDich etwa nicht?"
			6:
				return "Manche Menschen kannst\ndu echt in die Tonne kloppen..."
			7:
				return "Wurstwasser schmeckt leckaaaaaa."
			8:
				return "Bock auf ne Runde\nDestiny oder Halo?"
			9:
				return "Indie Spiele sind\ndie besten Spiele!"
			10:
				return "FICK AAAAAAAAA-Games."
			11:
				return "Spielentwickler denken auch\nsind die die Größten..."
			12:
				return "Ich bin mir ziemlich sicher\ndas wir in einer Simulation leben."
			13:
				return "Gehts dir gut?\nSiehst so...wütend aus."
			14:
				return "Pass bloß auf\nmit deinem Knüppel da."
			15:
				return ""
			16:
				return ""
			17:
				return ""
			18:
				return ""
			19:
				return ""
			20:
				return ""
			_:
				return "Moin!"
			

