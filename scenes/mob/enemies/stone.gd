extends "res://scenes/mob/enemies/enemy.gd"

func _ready():
	super()
	health = 125
	damage = 20
	initial_speed = 375
	@warning_ignore("integer_division")
	speed = int(initial_speed / 2)
	attack_speed = 2.2


func _process(_delta):
	check_animation()

func check_animation():
	
	if abs(player_direction.x) > abs(player_direction.y):
		#Movement in in der horizontalen
		$AnimationPlayer.play("enemy_02_walk")
	elif player_direction.y > 0:
		#Bewegung nach Unten
		pass
	elif player_direction.y < 0:
		#Bewegung naach Oben
		pass

	if player_direction.x > 0:
		#Bewegung nach Rechts
		$enemy_02_walk.flip_h = true
	elif player_direction.x < 0:
		#Bewegung naach Links
		$enemy_02_walk.flip_h = false
	
