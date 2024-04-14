extends CharacterBody2D

class_name Mob

@export var initial_health: int = 100
@export var initial_damage: int = 10
@export var initial_speed: int = 100
@export var initial_attack_speed: float = 3.0
var player
var health: int = 100
var damage: int = 10
var speed: int = 100
var attack_speed: float = 3.0
var last_attack_time: float = 0.0

func _init():
	health = initial_health
	damage = initial_damage
	speed = initial_speed
	attack_speed = initial_attack_speed

#func _ready():
	#timer = $AttackSpeedTimer
	#timer.wait_time = attack_speed
	#timer.connect("timeout", attack_player)

func _physics_process(delta):
	if player == null:
		player = $".."/Player
		
	check_attack_area(delta)

func receive_damage(dmg):
	print("mob receive_damage")
	health -= dmg
	if health <= 0:
		queue_free()
		if self is Enemy:
			Autoload.souls += 1

func check_attack_area(delta):
	var overlapping_enemies = $AttackArea.get_overlapping_bodies()
	if overlapping_enemies.size() > 0:
		for enemy in overlapping_enemies:
			enemy.last_attack_time -= delta
			if enemy.last_attack_time < 0.0:
				enemy.last_attack_time = enemy.attack_speed
				receive_damage(enemy.damage)

#func _on_area_2d_body_entered(body):
	#print("collide!")
	## TODO show attack animation on player body (not e.g. on tree body) entered
	#if body.has_method("receive_damage"):
		#print("has receive damage func")
		#timer.start()
	#else:
		#print("no receive_damage func")
		#
#func attack_player():
	#print("mob call func attack_player")
	#if player.is_alive:
		#player.receive_damage(damage)
	#else:
		#timer.stop()
	#


func _on_attack_area_body_entered(_body):
	pass # Replace with function body.
