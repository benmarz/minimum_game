class_name Gate
extends Node2D

signal exitted_scene(destination_scene, destination_gate, offset_pct)
export var is_horizontal := false
export var destination_scene : String
export var destination_gate : String

func _on_Exit_area_entered(area):
	var idx = 0 if is_horizontal else 1
	var offset = area.global_position[idx] - $Exit.global_position[idx]
	var max_offset = $Exit/CollisionShape2D.shape.extents[idx] - \
	                 Global.player.get_extents()[idx]
	var offset_pct = 0
	if offset >= max_offset:
		offset_pct = 1
	elif max_offset > 0:
		offset_pct = offset / max_offset
	print("player entered ", destination_scene, ", ", destination_gate, ": ", offset_pct)
	emit_signal("exitted_scene", destination_scene, destination_gate, offset_pct)


func enter_gate(offset_pct):
	var idx = 0 if is_horizontal else 1
	var pos = $Entrance.global_position
	var max_offset = $Entrance/CollisionShape2D.shape.extents[idx] - \
	                 Global.player.get_extents()[idx]
	var offset = 0
	offset_pct = clamp(offset_pct, -1, 1)
	if max_offset > 0:
		offset = offset_pct * max_offset
	pos[idx] = pos[idx] + offset
	Global.player.global_position = pos
