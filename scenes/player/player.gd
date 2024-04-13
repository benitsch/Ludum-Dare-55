extends CharacterBody2D

@export var speed: int = 400
@export var health: int = 200

var is_alive: bool = true

signal shoot
signal player_dead

func _physics_process(_delta):
	get_input()
	move_and_slide()
	
	# TODO add idle & move animation

func get_input():
	# Keyboard input
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction.normalized() * speed
	
	# Mouse input
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		shoot.emit()
		
	
func receive_damage(dmg):
	print("player call func receive_damage")
	health -= dmg
	if health <= 0:
		is_alive = false
		print("player dead")
		player_dead.emit()
		# TODO show game over screen and freeze/end game
