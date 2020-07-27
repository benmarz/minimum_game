class_name Treasure

extends "res://src/Entity.gd"

func _ready():
	if Global.has_treasure(name):
		queue_free()

func player_entered(body):
	if "treasures" in body:
		body.treasures += 1
		print("player now has ", body.treasures, " treasures")
		Global.add_tresure(name)
	queue_free()
