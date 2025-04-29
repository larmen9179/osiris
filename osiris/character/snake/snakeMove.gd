extends CharacterBody2D

@export var speed = 20
var player = null
var health = 3
@onready var sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var bark = $AudioStreamPlayer2D

func _ready():
	# Try to find player dynamically
	player = get_node_or_null("../Isis")
	bark.play()
	
func _physics_process(delta):
	
	
	
	
	if not player:
		return
	
	
	
	var direction = (player.global_position - global_position).normalized()
	
	
	move_and_slide()
	
	
	if abs(direction.x) > 0.1:
		if direction.x > 0:
			sprite.play("slither_right")
			collision_shape.rotation = 0
		else:
			sprite.play("slither_left")
			collision_shape.rotation = deg_to_rad(180)
	
	#var distance = global_position.distance_to(player.global_position)
	#bark.volume_db = bark.volume_db/distance

func take_damage(damageIn):
	health -= damageIn
	if health <= 0:
		queue_free()
