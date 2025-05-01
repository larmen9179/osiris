extends Area2D

@onready var direction: Vector2 = Vector2.ZERO
@onready var speed = 50

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
