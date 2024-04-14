extends Control

@export var summon_label_text = "1"
@export var friend_texture : Texture
var summon_cost = 0

@onready var summon_x = %SummonX
@onready var summon_label = %SummonLabel
@onready var summon_cost_label = %SummonCost
@onready var friend_image = $Container/TextureRectFriend
@onready var background_image = $Container/TextureRect
@onready var container = $Container

		
func _ready():
	summon_label.text = summon_label_text
	friend_image.texture = friend_texture
	setSummonCost(summon_label_text)

func set_color_intensity(intensity): # between 0 and 1
	background_image.material.set_shader_parameter("desaturate_strength",intensity)
	friend_image.material.set_shader_parameter("desaturate_strength",intensity)

func _process(_delta):
	if Autoload.souls >= summon_cost:
		set_color_intensity(1)
	else:
		set_color_intensity(0)

func setSummonCost(sumLab):
	if sumLab == "1":
		summon_cost = Autoload.spawn_F1
	elif sumLab == "2":
		summon_cost = Autoload.spawn_F2
	elif sumLab == "3":
		summon_cost = Autoload.spawn_F3
		
	summon_cost_label.text = str(summon_cost)
