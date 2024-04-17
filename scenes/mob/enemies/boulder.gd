extends "res://scenes/mob/enemies/enemy.gd"

func _init():
	super()
	health = 250
	damage = 40
	speed = 300
	attack_speed = 4.0

func _process(_delta):
	check_animation()

func check_animation():
	if abs(player_direction.x) > abs(player_direction.y):
		#Movement in in der horizontalen
		$AnimationPlayer.play("enemy_03_walk")
	elif player_direction.y > 0:
		#Bewegung nach Unten
		pass
	elif player_direction.y < 0:
		#Bewegung naach Oben
		pass

	if player_direction.x > 0:
		#Bewegung nach Rechts
		$enemy_03_walk.flip_h = true
	elif player_direction.x < 0:
		#Bewegung naach Links
		$enemy_03_walk.flip_h = false
