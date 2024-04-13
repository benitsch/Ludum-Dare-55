extends CharacterBody2D

@export var speed: int = 400

signal shoot

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
		
	
