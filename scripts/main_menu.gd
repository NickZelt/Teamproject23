extends Control

# change scene
func _change_scene(path_to_scene):
	for child in get_children():
		remove_child(child) # Crashes without explicitly removing from the scene.
		child.queue_free()

	var new_scene = load(path_to_scene).instantiate()
	add_child(new_scene)


# get called at the start
func _ready():
	
	Main.change_scene.connect(_change_scene)
	
	# get Video Stream Player node to attach finished signal to the node
	var videostream = get_node("Control/VideoStreamPlayer")
	videostream.finished.connect(loopMenuBackground)
	
# starts background video again after it finished	
func loopMenuBackground():
	$Control/VideoStreamPlayer.play()

#################### Main Menu ####################
# Play Button
func _on_play_pressed():
	#get_tree().change_scene_to_file("res://scenes/game.tscn")
	#Main.change_scene.emit("res://scenes/game.tscn")
	SceneTransition.change_scene_to_file('res://scenes/game.tscn')

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
