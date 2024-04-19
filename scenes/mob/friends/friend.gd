extends "res://scenes/mob/mob.gd"

class_name Friend

var personal_space: int = 400
var initial_max_health: int = 150
var initial_regeneration: int = 0
var partial_reg: float = 0
var enemy_targets: Array[Node2D]
var target: Node2D
var max_health: int 
var regeneration: int

func _ready():
	super()
	speed = initial_speed
	max_health = initial_max_health
	regeneration = initial_regeneration

func _physics_process(delta):
	super(delta)
	
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
	elif player != null:
		direction = global_position.direction_to(player.global_position)
		distance = (player.position - position).length() - personal_space
	
		if distance < -20:
			distance = -1 
		elif distance < -10:
			distance /= 20
		elif distance > 20:
			distance = 1
		elif distance > 10:
			distance /= 20
		else:
			distance = 0
	else:
		direction = Vector2.ZERO
		distance = 0
	
	velocity = direction * speed * distance
	move_and_slide()

func _on_area_2d_body_entered(body):
	enemy_targets.push_back(body)

func _on_area_2d_body_exited(body):
	enemy_targets.erase(body)

func increase_stats(aspects: Array[int]):
	if aspects[0] < 5:
		return
	
	damage = damage + damage * aspects[1] 
	max_health = max_health + 50 * aspects[2]
	health = max_health
	speed = speed + 25 * aspects[3]
	attack_speed = max(attack_speed - (0.35 * aspects[3]), 0.1)
	regeneration = regeneration + 1 * aspects[4]
