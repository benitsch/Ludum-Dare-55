extends "res://scenes/mob/mob.gd"

class_name Friend

@export var personal_space: int = 400
@export var max_health: int = 150
@export var regeneration: int = 0
var partial_reg: float = 0
var enemy_targets: Array[Node2D]
var target: Node2D

func _init():
	speed = 150

func _physics_process(delta):
	if health < max_health:
		partial_reg = partial_reg + regeneration * delta
		if partial_reg > 1:
			health += 1
			partial_reg -= 1
	else:
		partial_reg = 0
	
	if target == null && enemy_targets.size() > 0:
		target = enemy_targets.pop_back()
	
	var direction: Vector2 
	var distance: float 
	
	if target != null:
		direction = global_position.direction_to(target.global_position)
		distance = 1
	elif player == null:
		player = $".."/Player
		direction = Vector2.ZERO
		distance = 0
	else: 
		direction = global_position.direction_to(player.global_position)
		distance = (player.position - position).length() - personal_space
	
		if distance < -1:
			distance = -1 
		elif distance > 1:
			distance = 1
	
	velocity = direction * speed * distance	
	move_and_slide()

func _on_area_2d_body_entered(body):
	enemy_targets.push_back(body)

func _on_area_2d_body_exited(body):
	enemy_targets.erase(body)
