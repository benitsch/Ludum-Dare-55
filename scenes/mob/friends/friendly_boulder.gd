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
	if abs(player_direction.x) > abs(player_direction.y):
		#Movement in in der horizontalen
		$friend_03_animation.play("friend_03_walk")
	elif player_direction.y > 0:
		#Bewegung nach Unten
		pass
	elif player_direction.y < 0:
		#Bewegung naach Oben
		pass

	if player_direction.x > 0:
		#Bewegung nach Rechts
		$friend_03_walk.flip_h = true
	elif player_direction.x < 0:
		#Bewegung naach Links
		$friend_03_walk.flip_h = false
		
		
