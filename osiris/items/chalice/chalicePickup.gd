extends Area2D

func _on_Item_body_entered(body):	
	if body.name == "isis":
		
		#debug message
		print("Picked up chalice!")
		
		#grabbing the textBox in the current level (level1)
		get_node("/root/level1/textBox").show_message("You picked up the chalice!")
		
		#destroy the item after pickup
		queue_free()
