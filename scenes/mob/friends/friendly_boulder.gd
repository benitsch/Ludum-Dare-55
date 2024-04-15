extends "res://scenes/mob/friends/friend.gd"

func _init():	
	super()
	max_health = 400
	health = max_health
	damage = 45
	speed = 350
	attack_speed = 3.5
	regeneration = 1

func _process(_delta):
	check_animation()

func check_animation():
	
	if player_direction.x <= 0.1:  # Vertikale Bewegung (nach oben oder unten)
		pass
		#if player_direction.y <= 0.3:  # Bewegung nach oben oder unten
			#$player_sprite.flip_h = false
			#$AnimationPlayer.play("enemy_03_walk_up")
		#else:  # Bewegung nach unten
			#$player_sprite.flip_h = false
			#$AnimationPlayer.play("enemy_03_walk_down")
	elif player_direction.y <= 0.3:  # Horizontale Bewegung (nach links oder rechts)
		if player_direction.x > 0.3:  # Bewegung nach rechts
			$enemy_03_walk.flip_h = true
			$friend_03_animation.play("friend_03_walk")
		else:  # Bewegung nach links
			$enemy_03_walk.flip_h = false
			$friend_03_animation.play("friend_03_walk")
	
