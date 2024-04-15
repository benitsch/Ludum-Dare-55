extends Area2D

@export var friendsList: Array[PackedScene]

var failure_sounds = []
var puff_sound = preload("res://assets/sfx/puff.mp3")
var fail2_sound = preload("res://assets/sfx/fail2.mp3")

var success_summon_sound = preload("res://assets/sfx/summon.mp3")

var spawnIndex: int = -1
var aspect_values: Array[int] = [0, 0, 0, 0, 0]
var animator: AnimationPlayer
var fail_particles: CPUParticles2D
var summon_failed: bool = false
var aspect1: AnimatedSprite2D
var aspect2: AnimatedSprite2D
var aspect3: AnimatedSprite2D
var aspect4: AnimatedSprite2D
var aspect5: AnimatedSprite2D

signal spawn_friend(spawn_position, friend_index)

func _ready():
	failure_sounds.append(puff_sound)
	failure_sounds.append(fail2_sound)
	
	var offset: Vector2 = Vector2.ZERO
	offset.x = randf_range(-1, 1)
	offset.y = randf_range(-1, 1)
	offset = offset * randi_range(15, 55)
	position = position + offset
	animator = $AnimationPlayer
	fail_particles = $SummonFailParticle
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
	animator.speed_scale = 0.25
	animator.seek(0.75)
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
	var randomIdx = randi_range(0, failure_sounds.size() - 1 )
	AutoloadAudioStreamPlayer.play_SFX(failure_sounds[randomIdx], 15)
	summon_failed = true
	animator.pause()
	$MagicCircle.visible = false
	Autoload.is_summoning = false
	fail_particles.global_position = global_position
	fail_particles.restart()

func summon_mob():
	Autoload.is_summoning = false
	
	if not summon_failed && -1 < spawnIndex && spawnIndex < friendsList.size():
		var mob = friendsList[spawnIndex].instantiate()
		mob.position = global_position
		mob.increase_stats(aspect_values)
		$"..".add_child(mob)
		AutoloadAudioStreamPlayer.play_SFX(success_summon_sound)
	

func _on_summon_fail_particle_finished():
	queue_free()
