extends Area2D

@export var speed: int = 1000
@export var distance_range: int = 1300
@export var damage: int = 50

var travelled_distance: float = 0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta

	travelled_distance += speed * delta
	if travelled_distance > distance_range:
		queue_free()

func _on_body_entered(body: Mob):
	queue_free()
	if body.has_method("receive_damage"):
		body.receive_damage(damage)
