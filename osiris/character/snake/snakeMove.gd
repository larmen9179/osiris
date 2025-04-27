extends CharacterBody2D

@export var speed = 20
var player = null
var health = 3
@onready var sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

func _ready():
	# Try to find player dynamically
	player = get_node_or_null("../Isis")
	
func _physics_process(delta):
	if not player:
		return

	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	
	if abs(direction.x) > 0.1:
		if direction.x > 0:
			sprite.play("slither_right")
			collision_shape.rotation = 0
		else:
			sprite.play("slither_left")
			collision_shape.rotation = deg_to_rad(180)

func _on_body_entered(body):
	if body.name == "Isis":  # or check by group if you want
		if body.attacking:
			print("snake took damage")
			print(body.attacking)
			take_damage(1)

func take_damage(damageIn):
	health -= damageIn
	
	if health < 1:
		queue_free()
