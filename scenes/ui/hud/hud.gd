extends CanvasLayer

#var souls_value = 0
var health = 25;
@onready var souls_value_text = %SoulsLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#souls_value = Autoload.souls
	if souls_value_text.text != str(Autoload.souls):
		souls_value_text.text = str(Autoload.souls)


func _on_button_plus_pressed():
	Autoload.souls += 1


func _on_button_minus_pressed():
	Autoload.souls -= 1
