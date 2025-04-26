extends CanvasLayer

@onready var label = $Panel/Label
var textboxOpen = false

func show_message(text):
	label.text = text
	textboxOpen = true
	show()

func hide_message():
	hide()
	
func _process(delta):
	if textboxOpen and Input.is_action_just_pressed("ui_accept"):
		hide()
		textboxOpen = false
