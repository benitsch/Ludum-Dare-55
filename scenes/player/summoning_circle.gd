extends Area2D

@export var friendsList: Array[PackedScene]

var spawnIndex: int = -1
var aspect_values: Array[int] = [0, 0, 0, 0, 0]
var animator: AnimationPlayer
var particles: CPUParticles2D
var summon_failed: bool = false
var aspect1: AnimatedSprite2D
var aspect2: AnimatedSprite2D
var aspect3: AnimatedSprite2D
var aspect4: AnimatedSprite2D
var aspect5: AnimatedSprite2D

signal spawn_friend(spawn_position, friend_index)

func _ready():
	var offset: Vector2 = Vector2.ZERO
	offset.x = randf_range(-1, 1)
	offset.y = randf_range(-1, 1)
	offset = offset * randi_range(15, 55)
	position = position + offset
	animator = $AnimationPlayer
	particles = $SummonFailParticle
	aspect1 = $MagicCircle/Aspect1
	aspect1.visible = false
	aspect2 = $MagicCircle/Aspect2
	aspect2.visible = false
	aspect3 = $MagicCircle/Aspect3
	aspect3.visible = false
	aspect4 = $MagicCircle/Aspect4
	aspect4.visible = false
	aspect5 = $MagicCircle/Aspect5
	aspect5.visible = false

func _process(_delta):
	if summon_failed:
		if particles.finished: 
			queue_free()
		return
	
	if animator.current_animation_position < 1:
		if Input.is_action_just_pressed("aspect_up"):
			aspect_values[0] += 1
			aspect_values[1] += 1
			summon_addAspect(0)
		elif Input.is_action_just_pressed("aspect_down"):
			aspect_values[0] += 1
			aspect_values[2] += 1
			summon_addAspect(1)
		elif Input.is_action_just_pressed("aspect_left"): 
			aspect_values[0] += 1
			aspect_values[3] += 1
			summon_addAspect(3)
		elif Input.is_action_just_pressed("aspect_right"):
			aspect_values[0] += 1
			aspect_values[4] += 1
			summon_addAspect(2)
	elif 0 < aspect_values[0] && aspect_values[0] < 5:
		summon_fail()
	else:
		animator.speed_scale = 1
	
	if aspect_values[0] > 5:
		summon_fail()

func summon_addAspect(aspect_index):
	match aspect_values[0]:
		1:
			aspect1.frame = aspect_index
			aspect1.visible = true
		2:
			aspect2.frame = aspect_index
			aspect2.visible = true
		3:
			aspect3.frame = aspect_index
			aspect3.visible = true
		4:
			aspect4.frame = aspect_index
			aspect4.visible = true
		5:
			aspect5.frame = aspect_index
			aspect5.visible = true
		_:
			pass

func summon_fail():
	summon_failed = true
	animator.stop()
	$MagicCircle.visible = false
	Autoload.is_summoning = false
	particles.restart()

func summon_mob():
	Autoload.is_summoning = false
	
	if not summon_fail() && -1 < spawnIndex && spawnIndex < friendsList.size():
		var mob = friendsList[spawnIndex].instantiate()
		mob.position = global_position
		mob.increase_stats(aspect_values)
		$"..".add_child(mob)
