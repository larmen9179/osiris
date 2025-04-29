extends CanvasLayer

@onready var label = $Panel/Label
var textboxOpen = false

var tutorial_messages = []  # Tutorial text first
var isis_messages = []      # Story dialogue second
var current_messages = []   # This will point to which set we're currently showing

var message_index = 0       # Keeps track of which message we're on
var finished_tutorial = false  # Tracks if tutorial is done

func _ready():
	tutorial_messages = [
		"Welcome! (Press Spacebar to advance text.)",  
		"To move around:",
		"Press W to move up.",
		"Press A to move left.",
		"Press S to move down.",
		"Press D to move right.",
		"To use Isis’s Powers and Spells:",
		"Press K to use Isis’s spells.",
		"""Spell system:
1 = Scarabs (weak damage),
2 = Eye of Horus (medium damage),
3 = Ra the Sun God (high damage)."""
	]

	isis_messages = [
		"My love, my dear love, what has become of you?!",
		"They have defiled you, scattered your light to the winds.",
		"""But hear me, Osiris. I will not forsake you, my love. 
I will make you whole again, even if the sands of Egypt devour my flesh. 
Even if the gods themselves turn their faces away….""",
		"Through river, through root, through the endless sands... I will find you. I will make you whole."
	]

	current_messages = tutorial_messages  # Start with tutorial
	show_message(current_messages[message_index])

func show_message(text):
	label.text = text
	textboxOpen = true
	show()

func hide_message():
	hide()
	textboxOpen = false

func _process(delta):
	if textboxOpen and Input.is_action_just_pressed("ui_accept"):
		message_index += 1
		if message_index < current_messages.size():
			show_message(current_messages[message_index])
		else:
			if not finished_tutorial:
				# Finished tutorial, now move to Isis story
				finished_tutorial = true
				current_messages = isis_messages
				message_index = 0
				show_message(current_messages[message_index])
			else:
				# Finished everything
				hide_message()
