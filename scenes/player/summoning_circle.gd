extends Area2D

@export var friendsList: Array[PackedScene]

var spawnIndex: int = -1
signal spawn_friend(spawn_position, friend_index)

func summon_mob():
	if -1 < spawnIndex && spawnIndex < friendsList.size():
		var mob = friendsList[spawnIndex].instantiate()
		mob.position = global_position
		$"..".add_child(mob)
