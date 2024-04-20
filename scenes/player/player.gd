extends CharacterBody2D

var initial_speed: int = 400
var initial_health: int = 500
@export var tutorial: bool = false
var speed: int
var health: int 
var health_bar = null
var is_alive: bool = true
var distance_dmg_timeout: float = 0
var deadzone:= 0.2

signal shoot

func _ready():
	speed = initial_speed
	health = initial_health
	health_bar = %HealthBar
	health_bar.max_value = health
	health_bar.value = health
	

func _physics_process(delta):
	get_input()
	move_and_slide()
	check_hitbox()
	if not tutorial:
		check_position_distance(delta)

func get_input():
	# Keyboard input
	var direction: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down").normalized()
		
	var aim_direction: Vector2 = Input.get_vector(
		"controller_aim_left",
		"controller_aim_right",
		"controller_aim_up",
		"controller_aim_down").normalized()

	if direction != Vector2.ZERO:
		if direction.x == 0:  # Vertikale Bewegung (nach oben oder unten)
			if direction.y < 0:  # Bewegung nach oben
				$AnimationPlayer.play("player_walk_up")
			else:  # Bewegung nach unten
				$AnimationPlayer.play("player_walk")
		elif direction.y == 0:  # Horizontale Bewegung (nach links oder rechts)
			$AnimationPlayer.play("player_walk")
			if direction.x > 0:  # Bewegung nach rechts
				$player_sprite.flip_h = false
			else:  # Bewegung nach links
				$player_sprite.flip_h = true
		#else:  # Diagonale Bewegung
			#if direction.y < 0:  # Bewegung nach oben
				#if direction.x > 0:  # Bewegung nach rechts
					#$player_sprite.flip_h = false
					#$AnimationPlayer.play("player_walk_diagonal_up_right")
				#else:  # Bewegung nach links
					#$player_sprite.flip_h = true
					#$AnimationPlayer.play("player_walk_diagonal_up_left")
			#else:  # Bewegung nach unten
				#if direction.x > 0:  # Bewegung nach rechts
					#$player_sprite.flip_h = false
					#$AnimationPlayer.play("player_walk_diagonal_down_right")
				#else:  # Bewegung nach links
					#$player_sprite.flip_h = true
					#$AnimationPlayer.play("player_walk_diagonal_down_left")
	else:
		$AnimationPlayer.play("player_idle")
	
	velocity = direction * speed
	
	# Mouse input
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		shoot.emit()
	# Controller shot input
	elif  aim_direction.x != 0 or aim_direction.y != 0:
		shoot.emit(aim_direction);
		print("controller shoot")
		

func check_hitbox():
	var overlapping_enemies = %HitBox.get_overlapping_bodies()
	var dmg_to_take = 0
	if overlapping_enemies.size() > 0:
		for other in overlapping_enemies:
			if other.last_attack_time < 0.0:
				other.last_attack_time = other.attack_speed
				dmg_to_take += other.damage
	
	if dmg_to_take > 0:
		receive_damage(dmg_to_take)
	elif speed + 5 < initial_speed:
		speed += 5
	elif speed < initial_speed:
		speed = initial_speed

func receive_damage(dmg):
	$AnimationPlayer.play("player_dmg")
	if not is_alive:
		return
	
	speed = int(initial_speed * 0.5)
	health -= dmg
	if health > 0 :
		health_bar.value = health
	else:
		health_bar.value = 0 
		is_alive = false
		get_tree().change_scene_to_file("res://scenes/ui/game_over/game_over.tscn")

func check_position_distance(delta):
	if distance_dmg_timeout < 0 && position.length() > 7000:
		distance_dmg_timeout += 1
		var ddamage = 5 * (position.length() - 6000) / 100
		receive_damage(ddamage)
	elif position.length() < 7000:
		distance_dmg_timeout = 0
	else:
		distance_dmg_timeout -= delta
