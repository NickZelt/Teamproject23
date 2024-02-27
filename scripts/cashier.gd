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
	
	# player ends run
	if player_in_area and Input.is_action_just_pressed("interact"):
		charAnimation.play("talk")
		
		var random = RandomNumberGenerator.new()
		random.randomize()
		
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
			_:
				return "Moin!"
			
