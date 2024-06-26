extends Node2D

@export var summon_cooldown: float = 0.1
@export var summoning_distance: float = 200
@export var rotation_speed: int = 1000

const summon_cast: PackedScene = preload("res://scenes/player/summoning_circle.tscn")
var active_summon

# Called when the node enters the scene tree for the first time.
func _ready():
	$SummoningPoint.position.x = summoning_distance
	active_summon = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if (not Autoload.is_summoning) || (active_summon == null):
		if Input.is_action_pressed("spawn_n1"):
			start_summoning(0, Autoload.spawn_F1)
		elif Input.is_action_pressed("spawn_n2"):
			start_summoning(1, Autoload.spawn_F2)
		elif Input.is_action_pressed("spawn_n3"):
			start_summoning(2, Autoload.spawn_F3)
		
	var new_rotation = rotation_degrees + rotation_speed * delta
	if new_rotation > 1:
		new_rotation -= 1
	
	rotation_degrees = new_rotation 

func start_summoning(summonType: int, summonCost: int):
	if Autoload.souls < summonCost:
		return
	
	Autoload.is_summoning = true
	Autoload.souls -= summonCost
	active_summon = summon_cast.instantiate()
	active_summon.spawnIndex = summonType
	active_summon.position = $SummoningPoint.global_position
	$"..".get_parent().add_child(active_summon)
