extends Area2D

@export var speed = 150
@export var damage = 1
var direction = Vector2.ZERO

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
		queue_free()  # destroy orb after hitting
		
	
	
