extends "res://scenes/mob/friends/friend.gd"

func _ready():
	super()
	max_health = 150
	health = max_health
	damage = 25
	initial_speed = 400
	@warning_ignore("integer_division")
	speed = int(initial_speed / 2)
	attack_speed = 2.0
	regeneration = 1
	
func _process(_delta):
	check_animation()

func check_animation():
	if abs(player_direction.x) > abs(player_direction.y):
		#Movement in in der horizontalen
		$friend_02_animation.play("friend_02_walk")
	elif player_direction.y > 0:
		#Bewegung nach Unten
		pass
	elif player_direction.y < 0:
		#Bewegung naach Oben
		pass

	if player_direction.x > 0:
		#Bewegung nach Rechts
		$friend_02_walk.flip_h = true
	elif player_direction.x < 0:
		#Bewegung naach Links
		$friend_02_walk.flip_h = false
