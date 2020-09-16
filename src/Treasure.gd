class_name Treasure

extends "res://src/Entity.gd"

func _ready():
	if Global.has_treasure(name):
		queue_free()

func player_entered(body):
	if body.has_method("add_treasure"):
		body.add_treasure()
		Global.add_tresure(name)
	queue_free()
