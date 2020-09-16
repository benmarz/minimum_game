extends Node

const SAVE_FILE = "user://savegame.save"
const ALL_TREASURES = 9

var player : Player
var level: String = ""
var gate: String = ""

var curr_treasures : Dictionary = {}
var treasures : Dictionary = {}
var enemies : Dictionary = {}

func _add_item(item: String, items: Dictionary):
	if not level in items:
		items[level] = [item]
	elif not item in items[level]:
		items[level].append(item)


func add_tresure(treasure: String):
	_add_item(treasure, curr_treasures)


func add_enemy(enemy: String):
	_add_item(enemy, enemies)


func _has_item(item: String, items: Dictionary) -> bool:
	if level in items:
		return item in items[level]
	return false


func has_treasure(treasure: String) -> bool:
	return _has_item(treasure, treasures)


func has_enemy(enemy: String) -> bool:
	return _has_item(enemy, enemies)


func merge_treasures():
	for level in curr_treasures:
		if not level in treasures:
			treasures[level] = curr_treasures[level]
		else:
			treasures[level] = treasures[level] + curr_treasures[level]
	curr_treasures = {}
