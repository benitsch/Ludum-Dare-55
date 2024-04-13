extends Area2D

@export var cooldown = 0.5

const BULLET = preload("res://scenes/player/bullet.tscn")
var can_shoot = true

func _ready():
	$WeaponPivot/Sprite2D/Timer.wait_time = cooldown
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	look_at(get_global_mouse_position())

func shoot():
	can_shoot = false
	$WeaponPivot/Sprite2D/Timer.start()
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
