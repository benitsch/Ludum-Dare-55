extends Node2D

@export var summon_cooldown: float = 0.1
@export var summoning_distance: float = 250
@export var rotation_speed: int = 1000

const summon_cast: PackedScene = preload("res://scenes/player/summoning_circle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$SummoningPoint.position.x = summoning_distance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if $Timer.time_left == 0:
		if Input.is_action_pressed("spawn_n1"):
			start_summoning(0)
		elif Input.is_action_pressed("spawn_n2"):
			start_summoning(1)
		elif Input.is_action_pressed("spawn_n3"):
			start_summoning(2)
		
	var new_rotation = rotation_degrees + rotation_speed * delta
	if new_rotation > 1:
		new_rotation -= 1
	
	rotation_degrees = new_rotation 

func start_summoning(summonType: int):
	var cast = summon_cast.instantiate()
	cast.spawnIndex = summonType
	cast.position = $SummoningPoint.global_position
	$"..".get_parent().add_child(cast)
	$Timer.start(summon_cooldown)
