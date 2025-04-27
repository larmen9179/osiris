extends CharacterBody2D

@export var speed = 200
@export var punch_range = 50  # Distance at which you can hit an enemy
@export var damage = 10  # Damage dealt with the punch

@onready var random = RandomNumberGenerator.new()
@onready var enemy_area = $EnemyArea  # Assuming you have an Area2D for the enemy hit detection

func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_key_pressed(KEY_S):
		direction.x += 1
	if Input.is_key_pressed(KEY_D):
		direction.y += 1

	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	if velocity.length() > 0:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				$AnimatedSprite2D.play("right")
			else:
				$AnimatedSprite2D.play("left")
		else:
			if velocity.y > 0:
				$AnimatedSprite2D.play("down")
			else:
				$AnimatedSprite2D.play("up")
	else:
		$AnimatedSprite2D.stop()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			advance_text()
		elif event.keycode == KEY_K:
			isis_combat()

func advance_text():
	print("Advance text!")  # Replace with your dialogue logic

func isis_combat():
	print("Isis attacks with combat!")  # Replace with your attack animation/damage logic

	# Play punch animation
	$AnimatedSprite2D.play() 
	# Detect nearby enemy
	var enemy = get_nearest_enemy()
	if enemy and position.distance_to(enemy.position) <= punch_range:
		enemy.take_damage(damage)  # Assuming enemy has a `take_damage` method

func get_nearest_enemy() -> CharacterBody2D:
	# Example of detecting the nearest enemy. Adjust as needed.
	# This could be a RayCast2D, Area2D, or just checking all enemies in the scene.
	for enemy in get_tree().get_nodes_in_group("snake"):  # Assuming enemies are added to an "enemies" group
		if enemy is CharacterBody2D:
			return enemy
	return null
