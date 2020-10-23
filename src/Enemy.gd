class_name Enemy

extends "res://src/Entity.gd"

func _ready():
	if Global.has_enemy(name):
		queue_free()

func player_entered(_body):
	Global.add_enemy(name)
	$EnemySound.play()
	visible = false
	set_deferred("monitoring", false)
	yield($EnemySound, "finished")
	queue_free()
