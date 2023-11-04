extends CharacterBody2D

var speed = 17
var player_chase = false
var player = null

var health = 100
var player_in_attack_zone = false
var can_take_damage = true

func _physics_process(delta):
	deal_with_damage()
	update_health()
	
	# Player entered detection area
	if player_chase:
		position += (player.position - position) / speed
		$AnimatedSprite2D.play("running")
		
		# Enemy looks into the right position depending where the pplayer is
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true # follows player to the left
		else:
			$AnimatedSprite2D.flip_h = false # follows player to the right
	
	# Player left detection area
	else:
		$AnimatedSprite2D.play("idle")
		
		

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	$emotionHappy.hide()
	$emotionAngry.show()


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	$emotionHappy.show()
	$emotionAngry.hide()
	
	
func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_attack_zone = false
		
		
		
func deal_with_damage():
	if player_in_attack_zone and Game.player_current_attack == true:
		
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("Enemy Health: ", health)
			if health <= 0:
				self.queue_free() # eneme dead


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	
# Health system
func update_health():
	# update life from enemy to healthbar
	var healthbar = $healthbar
	healthbar.value = health
	
	# full life -> health bar wont be shown
	if health >= 100:
		healthbar.visible = false
	else: # health bar visible when not full life
		healthbar.visible = true
