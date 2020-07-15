extends Node2D

signal exitted_scene(destination_scene, destination_gate, offset)
export var is_horizontal := false
export var destination_scene : String
export var destination_gate : String

func _on_Exit_area_entered(area):
	var idx = 0 if is_horizontal else 1
	var off = area.global_position[idx] - $Exit.global_position[idx]
	var max_off = $Entrance/CollisionShape2D.shape.extents[idx] - \
	              Global.player.get_extents()[idx]
	var off_pct = 0
	if off >= max_off:
		off_pct = 1
	elif max_off > 0:
		off_pct = off / max_off
	print("player entered ", destination_scene, ", ", destination_gate, ": ", off_pct)
	emit_signal("exitted_scene", destination_scene, destination_gate, off_pct)
