extends CharacterBody2D

class_name Mob

var initial_health: int = 100
var initial_damage: int = 10
var initial_speed: int = 100
var initial_attack_speed: float = 3.0

var player
var health: int = 100
var damage: int = 10
var speed = 100
var attack_speed: float = 3.0
var last_attack_time: float = 0.0
var player_direction: Vector2 = Vector2.ZERO

func _ready():
	health = initial_health
	damage = initial_damage
	speed = initial_speed
	attack_speed = initial_attack_speed

func _physics_process(delta):
	if player == null:
		player = $".."/Player
	
	if last_attack_time >= 0:
		last_attack_time -= delta
	
	check_attack_area()

func receive_damage(dmg):
	@warning_ignore("integer_division")
	speed = int(initial_speed / 2)
	$TakeDmgAnim.play("takeing_dmg")
	
	health -= dmg
	if health <= 0:
		queue_free()
		if self is Enemy:
			Autoload.souls += 1
			Autoload.total_souls += 1

func check_attack_area():
	var overlapping_enemies = $AttackArea.get_overlapping_bodies()
	var dmg_to_take = 0
	if overlapping_enemies.size() > 0:
		for other in overlapping_enemies:
			if other.last_attack_time < 0.0:
				other.last_attack_time = other.attack_speed
				dmg_to_take += other.damage
	
	if dmg_to_take > 0:
		receive_damage(dmg_to_take)
	elif speed + 10 < initial_speed:
		speed += 10
	elif speed < initial_speed:
		speed = initial_speed  
