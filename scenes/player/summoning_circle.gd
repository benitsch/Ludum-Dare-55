extends Area2D

@export var friendsList: Array[PackedScene]

var spawnIndex: int = -1
var aspect_values: Array[int] = [0, 0, 0, 0, 0]
var animator: AnimationPlayer

signal spawn_friend(spawn_position, friend_index)

func _ready():
	var offset: Vector2 = Vector2.ZERO
	offset.x = randf_range(-1, 1)
	offset.y = randf_range(-1, 1)
	offset = offset * randi_range(15, 55)
	position = position + offset
	animator = $AnimationPlayer

func _process(_delta):
	if animator.current_animation_position < 1 && aspect_values[0] < 5:
		if Input.is_action_just_pressed("aspect_up"):
			aspect_values[0] += 1
			aspect_values[1] += 1
		elif Input.is_action_just_pressed("aspect_down"):
			aspect_values[0] += 1
			aspect_values[2] += 1
		elif Input.is_action_just_pressed("aspect_left"): 
			aspect_values[0] += 1
			aspect_values[3] += 1
		elif Input.is_action_just_pressed("aspect_right"):
			aspect_values[0] += 1
			aspect_values[4] += 1
	else:
		animator.speed_scale = 1

func summon_mob():
	if -1 < spawnIndex && spawnIndex < friendsList.size():
		var mob = friendsList[spawnIndex].instantiate()
		mob.position = global_position
		mob.increase_stats(aspect_values)
		$"..".add_child(mob)
