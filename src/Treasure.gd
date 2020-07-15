extends "res://src/Entity.gd"

func player_entered(body):
	if "treasures" in body:
		body.treasures += 1
		print("player now has ", body.treasures, " treasures")
	queue_free()
