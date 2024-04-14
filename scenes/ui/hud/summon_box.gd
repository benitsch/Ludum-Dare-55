extends Control

@export var summon_label_text = "Summon (1)"
@export var summon_cost = 3
@export var friend_texture : Texture

@onready var summon_x = %SummonX
@onready var summon_label = %SummonLabel
@onready var summon_cost_label = %SummonCost
@onready var friend_image = $Container/TextureRectFriend
@onready var background_image = $Container/TextureRect
@onready var container = $Container

		
func _ready():
	summon_label.text = summon_label_text
	summon_cost_label.text = str(summon_cost)
	friend_image.texture = friend_texture

func set_color_intensity(intensity): # between 0 and 1
	background_image.material.set_shader_parameter("desaturate_strength",intensity)
	friend_image.material.set_shader_parameter("desaturate_strength",intensity)

func _process(delta):
	print(str(Autoload.souls) + " " + str(summon_cost))
	if Autoload.souls >= summon_cost:
		set_color_intensity(1)
	else:
		set_color_intensity(0)
