extends CharacterBody2D

# max Movement Speed of the player
const maxSpeed = 200
const acceleration = 1000
const friction = 1500

# direction of the player
var current_direcition = "none"

# input by player
var input = Vector2.ZERO

# get Input by player
func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

# gives pyhsics properties to the player
func _physics_process(delta):
	player_movement(delta)

# Player movement with arrow keys
func player_movement(delta):
	
	# smoother player movement
	input = get_input()
	
	# no input by the player
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			# slowly decreases speed when the player sopts moving
			velocity -= velocity.normalized() * (friction * delta) 
		else:  # Player stops
			velocity = Vector2.ZERO
			
	else: # input by the player
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(maxSpeed)
	
	# Movement to the right when pressing the right arrow key
	if Input.is_action_pressed("ui_right"):
		current_direcition = "right"
		play_animation(1)
		
	# Movement to the left when pressing the left arrow key
	elif Input.is_action_pressed("ui_left"):
		current_direcition = "left"
		play_animation(1)

	# Move up when pressing the up arrow key
	elif Input.is_action_pressed("ui_down"):
		current_direcition = "down"
		play_animation(1)

	# Move down when pressing the down arrow key
	elif Input.is_action_pressed("ui_up"):
		current_direcition = "up"
		play_animation(1)

	# when now key is pressed (idle mode)
	else:
		play_animation(0)

	# built in - collision between player and ground
	move_and_slide()
	
# play animation based on the direction the player is pressing
func play_animation(movement):
	var direction = current_direcition
	var animation = $AnimatedSprite2D
	
	# player is walking right
	if direction == "right":
		#animation.flip_h = false
		if movement == 1:
			animation.play("running_right")
		else:
			animation.play("idle_right")
	
	# player is walking left
	if direction == "left":
		#animation.flip_h = true
		if movement == 1:
			animation.play("running_left")
		else:
			animation.play("idle_left")

	# player is walking up
	if direction == "up":
		#animation.flip_h = false
		if movement == 1:
			animation.play("running_left")
		else:
			animation.play("idle_left")
	
	# player is walking down
	if direction == "down":
		#animation.flip_h = false
		if movement == 1:
			animation.play("running_right")
		else:
			animation.play("idle_right")
		
