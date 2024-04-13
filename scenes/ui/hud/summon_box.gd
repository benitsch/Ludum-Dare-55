extends Control

@export var summon_label_text = "Summon (1)"
@export var summon_cost = 3
@export var friend_texture : Texture

@onready var summon_label = %SummonLabel
@onready var summon_cost_label = %SummonCost
@onready var friend_image = %TextureRectFriend

		
func _ready():
	summon_label.text = summon_label_text
	summon_cost_label.text = str(summon_cost)
	friend_image.texture = friend_texture
