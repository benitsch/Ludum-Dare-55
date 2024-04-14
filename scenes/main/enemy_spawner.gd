extends Node2D

@export var enemies: Array[PackedScene]
@export var wave_spawn_delay: float = 30.0

func _ready():
	$Timer.autostart = true
	$Timer.wait_time = wave_spawn_delay

func spawn_wave():
	pass

func _on_timer_timeout():
	spawn_wave()
