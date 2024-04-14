extends CanvasLayer

#var souls_value = 0
var health = 25;
@onready var souls_value_text = %SoulsLabel
@onready var wave_label = $WaveLabel
@onready var wave_timer_label = $WaveTimeLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# update number of collected souls
	if souls_value_text.text != str(Autoload.souls):
		souls_value_text.text = str(Autoload.souls)
	
	# update wave indicator
	var wave_text = "Wave " + str(Autoload.current_wave)
	if wave_label.text != wave_text:
		wave_label.text = wave_text
	
	# update indicator of next wave time
	var wave_timer_text = "Next wave in " + str(Autoload.wave_timer)
	if wave_timer_label.text != wave_timer_text:
		wave_timer_label.text = wave_timer_text

