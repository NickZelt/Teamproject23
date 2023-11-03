extends Control

# get called at the start
func _ready():
	
	# get Video Stream Player node to attach finished signal to the node
	var videostream = get_node("Control/VideoStreamPlayer")
	videostream.finished.connect(loopMenuBackground)
	
# starts background video again after it finished	
func loopMenuBackground():
	$Control/VideoStreamPlayer.play()

#################### Main Menu ####################
# Play Button
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

# Option Button
func _on_options_pressed():
	$MainMenu.hide()
	$OptionMenu.show()

# Credit Button
func _on_credits_pressed():
	$MainMenu.hide()
	$Credits.show()

# Quit game Button
func _on_quit_pressed():
	get_tree().quit()

#################### Option Menu ####################
# Volume Button
func _on_volume_pressed():
	pass # Replace with function body.

func _on_magic_button_pressed():
	pass # Replace with function body.

# Back to Main Menu Button
func _on_back_to_main_menu_pressed():
	$MainMenu.show()
	$OptionMenu.hide()
	
#################### Credit Menu ####################
func _on_credits_back_to_menu_pressed():
	$MainMenu.show()
	$Credits.hide()
