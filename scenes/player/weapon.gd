extends Node2D

@export var cooldown = 0.5

const BULLET = preload("res://scenes/player/bullet.tscn")
var can_shoot = true

func _ready():
	%Timer.wait_time = cooldown
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$WeaponPivot.look_at(get_global_mouse_position())

func shoot():
	can_shoot = false
	%Timer.start()
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	
	%ShootingPoint.add_child(new_bullet)

func _on_player_shoot():
	if not can_shoot:
		return
	shoot()

func _on_timer_timeout():
	can_shoot = true
