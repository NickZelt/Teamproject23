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
				random.randi_range(1, 11)
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
				return "Schönen guten Tag!"
			2:
				return "Grün ist Blau. Blau\nist Rot. Rot ist Grün."
			3:
				return "42."
			4:
				return "C-137"
			5:
				return "Die Phantasie ist\ndas Auge der Seele."
			6:
				return "Das ganze Leben\nist ein ewiges Wiederanfangen."
			7:
				return "Es hört doch jeder\nnur, was er versteht."
			8:
				return "Ich mag die Nacht.\nDa sind alle Schaukeln frei."
			9:
				return "Man muss auch mal die\nSchuld bei anderen suchen."
			10:
				return "Orangensaaaaaft!"
			11:
				return "Ziel der Reise\nist das Weinregal."
			12:
				return ""
			13:
				return ""
			14:
				return ""
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
			

