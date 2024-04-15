extends "res://scenes/mob/friends/friend.gd"

func _init():
	super()
	max_health = 75
	health = max_health
	damage = 5
	speed = 450
	attack_speed = 1.0
	regeneration = 0
	
func _process(_delta):
	check_animation()

func check_animation():
	if abs(player_direction.x) > abs(player_direction.y):
		#Movement in in der horizontalen
		$friend_01_animation.play("friend_01_walk")
	elif player_direction.y > 0:
		#Bewegung nach Unten
		pass
	elif player_direction.y < 0:
		#Bewegung naach Oben
		pass

	if player_direction.x > 0:
		#Bewegung nach Rechts
		$friend_01_walk.flip_h = true
	elif player_direction.x < 0:
		#Bewegung naach Links
		$friend_01_walk.flip_h = false
