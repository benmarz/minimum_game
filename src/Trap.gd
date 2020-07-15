extends "res://src/Entity.gd"

func player_entered(body):
	if body.has_method("killed"):
		body.killed()
