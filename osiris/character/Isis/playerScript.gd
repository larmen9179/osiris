extends CharacterBody2D

#storing player's audio sounds
@onready var attack_sound_1 :AudioStreamPlayer2D = $attackSound1
@onready var attack_sound_2 :AudioStreamPlayer2D = $attackSound2

#storing the scenes for the orb projectiles
#scarab orb
@export var scarab_scene: PackedScene
#ra orb
#@export var ra_scene: PackedScene
#horus orb
#@export var horus_scene: PackedScene

#player's speed
@export var speed: int = 100

#cooldown before next shot can be fired
@export var shoot_cooldown: float = .3

#random generator for random magic attack
@onready var random: RandomNumberGenerator = RandomNumberGenerator.new()

#storing the last direction as down so the first shot moves
var last_direction: Vector2 = Vector2.DOWN

#timer for the shot cooldown
var shoot_timer: float = 0.0

#boolean for attack state
var attacking: bool = false



func _physics_process(delta):
	#grabbing the Vector 2 that tells us what keys the user was pressing
	#for movement
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#adjusting the velocity based on direction and a constant speed
	velocity = direction * speed
	
	#only updating the last direction if we're actually moving
	#updating this WITHOUT boundary checks will make the orbs stand still
	if abs(direction.x) > 0 || abs(direction.y) > 0:
		last_direction = direction
	
	#moves the body based off the velocity changed earlier
	move_and_slide()
	
	#plays animation based on movement
	play_animation()
	
	#reduces the shoot timer if the timer has been reset for an attack
	if shoot_timer > 0:
		shoot_timer -= delta  
	
	#if velocity.length() > 0:
		#if abs(velocity.x) > abs(velocity.y):
			#if velocity.x > 0:
				#$AnimatedSprite2D.play("right")
			#else:
				#$AnimatedSprite2D.play("left")
		#else:
			#if velocity.y > 0:
				#$AnimatedSprite2D.play("down")
			#else:
				#$AnimatedSprite2D.play("up")
	#else:
		#$AnimatedSprite2D.stop()
	
	shoot_timer -= delta  
	
#detects input
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_K:
			#spell cast method
			use_spell()

#method for playing animation given the users previously pressed direction
func play_animation():
	if velocity.length() > 0:
		if abs(last_direction.x) > abs(last_direction.y):
			if last_direction.x > 0:
				$AnimatedSprite2D.play("right")
			else:
				$AnimatedSprite2D.play("left")
		else:
			if last_direction.y > 0:
				$AnimatedSprite2D.play("down")
			else:
				$AnimatedSprite2D.play("up")
	else:
		if abs(last_direction.x) > abs(last_direction.y):
			if last_direction.x > 0:
				$AnimatedSprite2D.play("idle_right")
			else:
				$AnimatedSprite2D.play("idle_left")
		else:
			if last_direction.y > 0:
				$AnimatedSprite2D.play("idle_down")
			else:
				$AnimatedSprite2D.play("idle_up")
	
	

#temporary function header
#func play_attack_animation():
	
# to cast spell
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

	#spawning specific spell
	var spell_number = random.randi_range(1, 3)
	match spell_number:
		1:
			print("Isis summons Scarabs! (Weak Damage)")
			summon_spell_orb(scarab_scene)
		2:
			print("Isis summons the Eye of Horus! (Medium Damage)")
			summon_spell_orb(scarab_scene)
		3:
			print("Isis calls upon Ra the Sun God! (Strongest Damage)")
			summon_spell_orb(scarab_scene)

func summon_spell_orb(spell_scene: PackedScene):
	var orb = scarab_scene.instantiate()
	get_parent().add_child(orb)
	orb.global_position = global_position
	orb.direction = last_direction
	
