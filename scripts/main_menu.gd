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
	$MarginContainer/Main.hide()
	$MarginContainer/Options.show()

# Credit Button
func _on_credits_pressed():
	$MarginContainer/Main.hide()
	$MarginContainer/Credits.show()

# Quit game Button
func _on_quit_pressed():
	get_tree().quit()

#################### Option Menu ####################
# Volume Button
func _on_volume_pressed():
	pass # Replace with function body.

# Back to Main Menu Button
func _on_back_pressed():
	$MarginContainer/Options.hide()
	$MarginContainer/Main.show()
	
#################### Credit Menu ####################
func _on_credit_back_pressed():
	$MarginContainer/Credits.hide()
	$MarginContainer/Main.show()
