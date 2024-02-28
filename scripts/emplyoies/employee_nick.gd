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
	
	charAnimation.flip_h = true
	charAnimation.play("idle")
	
	# player ends run
	if player_in_area and Input.is_action_just_pressed("interact"):
		var random = RandomNumberGenerator.new()
		random.randomize()
		
		# picks a random text
		talk(
			dialogue_picker(
				random.randi_range(1, 20)
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
				return "Moin!"
			2:
				return "Nur ein Zelt ist ein Zelt."
			3:
				return "Der Adam Driver ist \nschon ein ganz netter..."
			4:
				return "Hau ab jetzt und \nlass mich in ruhe."
			5:
				return "Ähhh...okay."
			6:
				return "Ich hasse Menschen."
			7:
				return "Hast du Eis? Nein? \nDann hau ab."
			8:
				return "Pups."
			9:
				return "Dummheit kennt keine Grenzen,\naber sehr viele Leute."
			10:
				return "Klopapier spielt eine\nwichtige Rolle im Leben."
			11:
				return "Lattenrost ist\n keine Geschlechskrankheit."
			12:
				return "Wenn ich du wäre,\nwäre ich lieber ich."
			13:
				return "Für die Erste Ordnung!!!"
			14:
				return "0100110101101111011010010110111000100001001000000101011101100101011011100110111000100000011001000111010100100000011001000110000101110011001000000110100001101001011001010111001000100000011011000110010101110011011001010110111000100000011010110110000101101110011011100111001101110100001011000010000001110011011011110110110001101100011101000110010101110011011101000010000001100100011101010010000001100100011010010111001000100000011101010110111001100010011001010110010001101001011011100110011101110100001000000110010101101001011011100010000001101110011001010111010101100101011100110010000001001000011011110110001001100010011110010010000001110011011101010110001101101000011001010110111000101110"
			15:
				return "Eine Hochzeit ist wie\neine Beerdigung mit Kuchen."
			16:
				return "Juckt mich nicht."
			17:
				return "Mir egal."
			18:
				return "Aha."
			19:
				return "Jo, du mich auch."
			20:
				return "Geh...endlich...bitte..."
			_:
				return "Moin!"
			
