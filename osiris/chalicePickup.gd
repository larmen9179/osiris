extends Area2D

func _on_Item_body_entered(body):
	if body.name == "Isis":
		# Play pickup sound or animation if you want
		print("Picked up chalice!")
		# Add to inventory, heal player, whatever effect
		# (You'd call a method on the player probably)
		#body.add_item(self)  # (if you have an add_item function)
		queue_free()  # Destroy the item after pickup
