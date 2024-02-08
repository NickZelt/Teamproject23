extends CharacterBody2D

@export var inventory: Inventory


# max Movement Speed of the player
const maxSpeed = 200
const acceleration = 5000
const friction = 5000

# direction of the player
var current_direcition = "none"

# combat
var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

var attack_in_progress = false


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
	enemy_attack()
	attack()
	update_health()
	
	if health <= 0:
		player_alive = false # add death screen
		health = 0
		print("Player has been killed.")
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		self.queue_free()

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
	
	if direction != "none":
	
		# player is walking right
		if direction == "right":
			animation.flip_h = true
			if movement == 1:
				animation.play("running_left")
			elif movement == 0:
				if attack_in_progress == false:
					animation.play("idle_left")
		
		# player is walking left
		if direction == "left":
			animation.flip_h = false
			if movement == 1:
				animation.play("running_left")
			elif movement == 0:
				if attack_in_progress == false:
					animation.play("idle_left")

		# player is walking up
		if direction == "up":
			if movement == 1:
				animation.play("running_left")
			elif movement == 0:
				if attack_in_progress == false:
					animation.play("idle_left")
		
		# player is walking down
		if direction == "down":
			if movement == 1:
				animation.play("running_left")
			elif movement == 0:
				if attack_in_progress == false:
					animation.play("idle_left")
				
	else:
		animation.flip_h = true
		animation.play("idle_left")
			

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false
		
func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 10
		enemy_attack_cooldown = false
		$take_damage_cooldown.start()
		print(health)


func _on_take_damage_cooldown_timeout():
	enemy_attack_cooldown = true
	
func attack():
	var direction = current_direcition
	var animation = $AnimatedSprite2D
	
	if Input.is_action_just_pressed("attack"):
		Game.player_current_attack = true
		attack_in_progress = true
		if direction == "right":
			animation.flip_h = true
			animation.play("slay_left_weapon")
			$deal_attack_timer.start()
			
		if direction == "left":
			animation.flip_h = false
			animation.play("slay_left_weapon")
			$deal_attack_timer.start()
			
		if direction == "down":
			animation.flip_h = true
			animation.play("slay_left_weapon")
			$deal_attack_timer.start()
			
		if direction == "up":
			animation.flip_h = false
			animation.play("slay_left_weapon")
			$deal_attack_timer.start()


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Game.player_current_attack = false
	attack_in_progress = false
	
func _on_back_to_main_menu_pressed():
	#get_tree().change_scene_to_file("res://scenes/main.tscn")
	Main.change_scene.emit("res://scenes/main.tscn")


# Health system
func update_health():
	# update life from player to healthbar
	var healthbar = $healthbar
	healthbar.value = health
	
	# full life -> health bar wont be shown
	if health >= 100:
		healthbar.visible = false
	else: # health bar visible when not full life
		healthbar.visible = true

# Health regeneration
func _on_regeneration_timer_timeout():
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0

func collect(item):
	inventory.insert(item)
