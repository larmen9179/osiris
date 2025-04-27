extends Area2D

func _on_Item_body_entered(body):
	if body.name == "Isis":
		# Play pickup sound or animation if you want
		print("Picked up chalice!")
		
		# Add to inventory, heal player, whatever effect
		# (You'd call a method on the player probably)
		#body.add_item(self)  # (if you have an add_item function)
		get_node("/root/level1/textBox").show_message("You picked up Osiris' legs")
		queue_free()  # Destroy the item after pickup
		
		go_to_next_level()

func go_to_next_level():
	get_tree().change_scene_to_file("res://levels/level2.tscn")
