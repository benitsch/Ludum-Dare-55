extends CharacterBody2D

@export var speed: int = 400
@export var health: int = 200
var health_bar = null

var is_alive: bool = true

signal shoot
signal player_dead

func _ready():
	health_bar = %HealthBar
	health_bar.max_value = health
	health_bar.value = health
	

func _physics_process(delta):
	get_input()
	move_and_slide()
	check_hitbox(delta)

	# TODO add idle & move animation

func get_input():
	# Keyboard input
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction.normalized() * speed
	
	# Mouse input
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		shoot.emit()

func check_hitbox(delta):
	var overlapping_enemies = %HitBox.get_overlapping_bodies()
	if overlapping_enemies.size() > 0:
		for enemy in overlapping_enemies:
			enemy.last_attack_time -= delta
			if enemy.last_attack_time < 0.0:
				enemy.last_attack_time = enemy.attack_speed
				receive_damage(enemy.damage)

func receive_damage(dmg):
	print("player call func receive_damage with dmg:", dmg)
	health -= dmg
	health_bar.value = health
	if health <= 0:
		is_alive = false
		print("player dead")
		player_dead.emit()
		get_tree().change_scene_to_file("res://scenes/ui/game_over/game_over.tscn")
