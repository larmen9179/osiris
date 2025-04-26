extends CanvasLayer

@onready var label = $Panel/Label

func show_message(text):
	label.text = text
	show()

func hide_message():
	hide()
