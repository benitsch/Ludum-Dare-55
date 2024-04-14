extends Node2D

@export var weakEnemies: Array[PackedScene]
@export var mediumEnemies: Array[PackedScene]
@export var strongEnemies: Array[PackedScene]
@export var wave_spawn_delay: float = 30.0
@export var difficultyRandomFactor: float = 0.5

var baseWeakEnemiesPerWave = 3
var baseMediumEnemiesPerWave = 2
var baseStrongEnemiesPerWave = 1

var player = null
var weakEnemiesList = []
var mediumEnemiesList = []
var strongEnemiesList = []

func _ready():
	player = $".."/Player
	print("EnemySpawner ready func")
	$Timer.wait_time = wave_spawn_delay
	$Timer.start()
	spawn_wave(Autoload.current_wave, true)

func _process(_delta):
	var current_time = $Timer.time_left
	var current_seconds = int(current_time)
	if current_seconds != Autoload.wave_timer:
		print(current_seconds)
		Autoload.wave_timer = current_seconds

# Funktion zum Spawnen einer Welle von Feinden
func spawn_wave(waveNumber, defer = false):
	print("Spawn Wave Nr:", waveNumber)
	# Berechne die Basisanzahl von Feinden für jeden Typ
	var baseWeakCount = waveNumber * baseWeakEnemiesPerWave
	var baseMediumCount = waveNumber * baseMediumEnemiesPerWave
	var baseStrongCount = waveNumber * baseStrongEnemiesPerWave

	# Wende den Zufallsfaktor auf jede Basisanzahl an
	var weakCount = int((baseWeakCount * (1.0 + randf() * difficultyRandomFactor)) / 2)
	var mediumCount = int((baseMediumCount * (1.0 + randf() * difficultyRandomFactor)) / 2)
	var strongCount = int((baseStrongCount * (1.0 + randf() * difficultyRandomFactor)) / 2)
	
	#var totalEnemies = weakCount + mediumCount + strongCount
	
	#print("totalEnemies:", totalEnemies)
	#print("weakCount", round(weakCount))
	#print("mediumCount", round(mediumCount))
	#print("strongCount", round(strongCount))
	# Feinde spawnen
	spawnEnemies(weakEnemies, round(weakCount), defer)
	spawnEnemies(mediumEnemies, round(mediumCount), defer)
	spawnEnemies(strongEnemies, round(strongCount), defer)
	
	Autoload.current_wave += 1

# Funktion zum Spawnen von Feinden
func spawnEnemies(enemyList, count, defer):
	for i in range(count):
		var enemyIndex = randi() % enemyList.size()
		var enemyType = enemyList[enemyIndex]
		print(enemyType)
		spawnEnemy(enemyType, defer)

func spawnEnemy(enemyType, defer):
	# Zufälligen Punkt rund um den Spieler berechnen
	var playerPosition = player.global_position
	var spawnRadius = 1500  # Radius, in dem Feinde spawnen sollen
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
	print("on timer timeout spawner")
	spawn_wave(Autoload.current_wave)
