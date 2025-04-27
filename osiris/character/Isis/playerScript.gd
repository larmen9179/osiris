extends CharacterBody2D

@onready var attack_sound_1 = $attackSound1  # <-- or whatever you named it
@onready var attack_sound_2 = $attackSound2
@export var scarab_scene: PackedScene
@export var ra_scene: PackedScene
@export var horus_scene: PackedScene
@export var speed = 100
@export var shoot_cooldown = .3
@onready var random = RandomNumberGenerator.new()
@onready var tilemap = get_parent().get_node("/level1/Terrain")
var last_direction = Vector2.RIGHT  # default facing right

var shoot_timer = 0.0


func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_key_pressed(KEY_D):
		direction.x += 1
	if Input.is_key_pressed(KEY_S):
		direction.y += 1

	if direction.length() > 0:
		last_direction = direction.normalized()
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
	
	shoot_timer -= delta  
	

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_K:
			use_spell()

func use_spell():
	
	if shoot_timer > 0:
		return  # prevent spamming

	shoot_timer = shoot_cooldown  # reset cooldown

	# 🔥 Play attack animation based on last move direction
	if abs(last_direction.x) > abs(last_direction.y):
		if last_direction.x > 0:
			$AnimatedSprite2D.play("attack_right")
		else:
			$AnimatedSprite2D.play("attack_left")
	else:
		if last_direction.y > 0:
			$AnimatedSprite2D.play("attack_down")
		else:
			$AnimatedSprite2D.play("attack_up")

	var attackNumber = random.randi_range(1, 7)
	if attackNumber >= 1 and attackNumber <= 6:
		attack_sound_1.play()
	else:
		attack_sound_2.play()
	

	# 🔥 Then summon the spell orb
	var spell_number = random.randi_range(1, 3)
	match spell_number:
		1:
			print("Isis summons Scarabs! (Weak Damage)")
			summon_spell_orb(scarab_scene)
		2:
			print("Isis summons the Eye of Horus! (Medium Damage)")
			summon_spell_orb(horus_scene)
		3:
			print("Isis calls upon Ra the Sun God! (Strongest Damage)")
			summon_spell_orb(ra_scene)

func summon_spell_orb(spell_scene: PackedScene):
	var orb = spell_scene.instantiate()
	get_parent().add_child(orb)
	orb.global_position = global_position
	orb.direction = last_direction.normalized()
