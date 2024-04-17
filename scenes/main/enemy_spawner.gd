extends Node2D

@export var weakEnemies: Array[PackedScene]
@export var mediumEnemies: Array[PackedScene]
@export var strongEnemies: Array[PackedScene]
@export var difficultyRandomFactor: float = 0.5

var success_wave_sound = preload("res://assets/sfx/yeah.mp3")

var wave_spawn_delay: int = 10
var baseWeakEnemiesPerWave = 2.5
var baseMediumEnemiesPerWave = 1.5
var baseStrongEnemiesPerWave = 0.2

var player = null
var weakEnemiesList = []
var mediumEnemiesList = []
var strongEnemiesList = []

func _ready():
	player = $".."/Player
	$Timer.wait_time = wave_spawn_delay
	$Timer.start()
	spawn_wave(Autoload.current_wave, true)

func _process(_delta):
	var current_time = $Timer.time_left
	var current_seconds = int(current_time)
	if current_seconds != Autoload.wave_timer:
		Autoload.wave_timer = current_seconds

# Funktion zum Spawnen einer Welle von Feinden
func spawn_wave(waveNumber, defer = false):
	# Berechne die Basisanzahl von Feinden für jeden Typ
	var baseWeakCount = waveNumber * baseWeakEnemiesPerWave
	var baseMediumCount = waveNumber * baseMediumEnemiesPerWave
	var baseStrongCount = waveNumber * baseStrongEnemiesPerWave

	# Wende den Zufallsfaktor auf jede Basisanzahl an
	var weakCount = 1 + int((baseWeakCount * (1.0 + randf() * difficultyRandomFactor)) / 1.2)
	var mediumCount = int((baseMediumCount * (1.0 + randf() * difficultyRandomFactor)) / 1.5)
	var strongCount = int((baseStrongCount * (1.0 + randf() * difficultyRandomFactor)) / 0.9)

	# Feinde spawnen
	spawnEnemies(weakEnemies, round(weakCount), defer)
	spawnEnemies(mediumEnemies, round(mediumCount), defer)
	spawnEnemies(strongEnemies, round(strongCount), defer)
	

# Funktion zum Spawnen von Feinden
func spawnEnemies(enemyList, count, defer):
	for i in range(count):
		var enemyIndex = randi() % enemyList.size()
		var enemyType = enemyList[enemyIndex]
		spawnEnemy(enemyType, defer)

func spawnEnemy(enemyType, defer):
	# Zufälligen Punkt rund um den Spieler berechnen
	var playerPosition = player.global_position
	var spawnRadius = 2500 + randi_range(0, 500) # Radius, in dem Feinde spawnen sollen
	var spawnAngle = randf_range(0, 2 * PI)  # Zufälliger Winkel
	var spawnOffset = Vector2(cos(spawnAngle), sin(spawnAngle)) * spawnRadius
	var spawnPosition = playerPosition + spawnOffset
	var parent = get_parent()
	# Instanz des Feindes erstellen und der Szene hinzufügen
	var enemyInstance = enemyType.instantiate()
	enemyInstance.global_position = spawnPosition
	if defer:
		parent.add_child.call_deferred(enemyInstance)
	else:
		parent.add_child(enemyInstance)


func _on_timer_timeout():
	Autoload.current_wave += 1
	AutoloadAudioStreamPlayer.play_SFX(success_wave_sound)
	if Autoload.current_wave > 8:
		$Timer.wait_time = 30
	elif Autoload.current_wave > 5:
		$Timer.wait_time = 20
	elif Autoload.current_wave > 1:
		$Timer.wait_time = 15
	
	spawn_wave(Autoload.current_wave)
