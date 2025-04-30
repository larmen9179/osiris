extends CharacterBody2D

#storing player's audio sounds
@onready var attack_sound_1 :AudioStreamPlayer2D = $attackSound1
@onready var attack_sound_2 :AudioStreamPlayer2D = $attackSound2

#storing the scenes for the orb projectiles
#scarab orb
@export var scarab_scene: PackedScene
#ra orb
@export var ra_scene: PackedScene
#horus orb
@export var horus_scene: PackedScene

#player's speed
@export var speed: int = 100
#-----------------------TESTING-----------------------
@export var shoot_cooldown = .3
@onready var random = RandomNumberGenerator.new()
var last_direction: Vector2 = Vector2.DOWN
var shoot_timer = 0.0
#-----------------------------------------------------



func _physics_process(delta):
	#grabbing 
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	
	last_direction = direction

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
		return

	shoot_timer = shoot_cooldown
	
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

	#playing attack audio based off chance (for rare dialogue)
	var attackNumber = random.randi_range(1, 7)
	if attackNumber >= 1 and attackNumber <= 6:
		attack_sound_1.play()
	else:
		attack_sound_2.play()

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
	orb.direction = last_direction
