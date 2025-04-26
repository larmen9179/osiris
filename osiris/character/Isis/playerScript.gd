extends CharacterBody2D

@export var speed = 200
@onready var random = RandomNumberGenerator.new()

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
		elif event.keycode == KEY_J:
			hand_to_hand_combat()
		elif event.keycode == KEY_K:
			use_spell()

func advance_text():
	print("Advance text!")  # Replace with your dialogue logic

func hand_to_hand_combat():
	print("Isis attacks with hand-to-hand combat!")  # Replace with your attack animation/damage logic

func use_spell():
	var spell_number = random.randi_range(1, 3)
	match spell_number:
		1:
			print("Isis summons Scarabs! (Weak Damage)")  # Replace with Scarab attack
		2:
			print("Isis summons the Eye of Horus! (Medium Damage)")  # Replace with Eye of Horus attack
		3:
			print("Isis calls upon Ra the Sun God! (Strongest Damage)")  # Replace with Ra attack
