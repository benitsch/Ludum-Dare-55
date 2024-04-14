extends CharacterBody2D

@export var speed: int = 400
@export var health: int = 500
var health_bar = null
var is_alive: bool = true

signal shoot

func _ready():
	health_bar = %HealthBar
	health_bar.max_value = health
	health_bar.value = health
	

func _physics_process(delta):
	get_input()
	move_and_slide()
	check_hitbox(delta)

func get_input():
	# Keyboard input
	var direction: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down").normalized()

	if direction != Vector2.ZERO:
		if direction.x == 0:  # Vertikale Bewegung (nach oben oder unten)
			if direction.y < 0:  # Bewegung nach oben
				$player_sprite.flip_h = false
				$AnimationPlayer.play("player_walk_up")
			#else:  # Bewegung nach unten
				#$player_sprite.flip_h = false
				#$AnimationPlayer.play("player_walk_down")
		elif direction.y == 0:  # Horizontale Bewegung (nach links oder rechts)
			if direction.x > 0:  # Bewegung nach rechts
				$player_sprite.flip_h = false
				$AnimationPlayer.play("player_walk")
			else:  # Bewegung nach links
				$player_sprite.flip_h = true
				$AnimationPlayer.play("player_walk")
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
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		$AnimationPlayer.play("player_idle")
	
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
	health -= dmg
	health_bar.value = health
	if not is_alive or health <= 0:
		is_alive = false
		get_tree().change_scene_to_file("res://scenes/ui/game_over/game_over.tscn")
