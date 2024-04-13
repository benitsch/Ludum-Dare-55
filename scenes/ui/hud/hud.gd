extends CanvasLayer

var souls_value = 0
var health = 25;
@onready var souls_value_text = %SoulsLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_grant_soul_pressed():
	souls_value += 1
	souls_value_text.text = str(souls_value)
