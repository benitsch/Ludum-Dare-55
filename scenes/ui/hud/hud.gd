extends CanvasLayer

var souls_value = 0
var health = 25;
@onready var souls_value_text = %SoulsLabel
@onready var health_bar = %HealthBar

# Called when the node enters the scene tree for the first time.
#func _ready():
	#health_bar.value = health
	#souls_value_text.text = str(souls_value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_grant_soul_pressed():
	souls_value += 1
	souls_value_text.text = str(souls_value)


func _on_grant_health_btn_pressed():
	health += 1
	health_bar.value = health
