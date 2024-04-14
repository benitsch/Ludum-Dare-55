extends Node2D

@export var weakEnemies: Array[PackedScene]
@export var mediumEnemies: Array[PackedScene]
@export var strongEnemies: Array[PackedScene]
@export var wave_spawn_delay: float = 30.0
@export var difficultyRandomFactor: float = 0.5

var baseWeakEnemiesPerWave = 3
var baseMediumEnemiesPerWave = 2
var baseStrongEnemiesPerWave = 1

func _ready():
	print("EnemySpawner ready func")
	$Timer.wait_time = wave_spawn_delay
	$Timer.start()

# Funktion zum Spawnen einer Welle von Feinden
func spawn_wave(waveNumber):
	print("Spawn Wave Nr:", waveNumber)
	# Berechne die Basisanzahl von Feinden für jeden Typ
	var baseWeakCount = waveNumber * baseWeakEnemiesPerWave
	var baseMediumCount = waveNumber * baseMediumEnemiesPerWave
	var baseStrongCount = waveNumber * baseStrongEnemiesPerWave

	# Wende den Zufallsfaktor auf jede Basisanzahl an
	var weakCount = int((baseWeakCount * (1.0 + randf() * difficultyRandomFactor)) / 2)
	var mediumCount = int((baseMediumCount * (1.0 + randf() * difficultyRandomFactor)) / 2)
	var strongCount = int((baseStrongCount * (1.0 + randf() * difficultyRandomFactor)) / 2)
	
	var totalEnemies = weakCount + mediumCount + strongCount
	
	print("totalEnemies:", totalEnemies)
	print("weakCount", round(weakCount))
	print("mediumCount", round(mediumCount))
	print("strongCount", round(strongCount))
	
	# Feinde spawnen
	spawnEnemies(weakEnemies, round(weakCount))
	spawnEnemies(mediumEnemies, round(mediumCount))
	spawnEnemies(strongEnemies, round(strongCount))
	
	Autoload.current_wave += 1

# Funktion zum Spawnen von Feinden
func spawnEnemies(enemyList, count):
	for i in range(count):
		var enemyIndex = randi() % enemyList.size()
		var enemyType = enemyList[enemyIndex]
		spawnEnemy(enemyType)

# Funktion zum Spawnen eines einzelnen Feindes
func spawnEnemy(enemyType):
	# Hier implementierst du die Logik zum Spawnen eines Feindes
	# Z.B. erstelle eine Instanz des Feindes und füge sie der Szene hinzu
	#print("Spawned enemy of type:", enemyType)
	pass

func _on_timer_timeout():
	print("on timer timeout spawner")
	spawn_wave(Autoload.current_wave)
