extends Node

# must be called in idle state
func _load_level(level_str: String, gate_str: String, offset_pct: float):
	Global.level = level_str
	Global.gate = gate_str
	Global.player.disable()
	Global.player.count_treasures()
	var level_resource := load(level_str)
	# TODO: check for null level_resource, and load default secene
	var level = level_resource.instance()
	$Level.add_child(level)
	var gate = level.get_node(gate_str)
	# TODO: check that we actually got a Gate, or find default gate
	gate.enter_gate(offset_pct)
	connect_gates(level)
	# wait till the next physics frame for the player's location to be updated.
	yield(get_tree(), "physics_frame")
	Global.player.enable()


func connect_gates(level: Node):
	for idx in level.get_child_count():
		var node = level.get_child(idx)
		if node is Gate:
			node.connect("exitted_scene", self, "_on_exitted_scene")


# must be called in idle state
func _switch_level(level_str: String, gate_str: String, offset_pct: float):
	var old_level = $Level.get_child(0)
	# TODO: check if we actually got a child
	$Level.remove_child(old_level)
	old_level.free()
	Global.merge_treasures()
	_load_level(level_str, gate_str, offset_pct)


func reload_level():
	Global.enemies = {}
	Global.curr_treasures = {}
	call_deferred("_switch_level", Global.level, Global.gate, 0)


func start_game():
	call_deferred("_load_level", "res://src/levels/Level1.tscn", "StartGate", 0)


func restart_game():
	Global.enemies = {}
	Global.curr_treasures = {}
	Global.treasures = {}
	call_deferred("_switch_level", "res://src/levels/Level1.tscn", "StartGate", 0)


func _on_exitted_scene(level_str, gate_str, offset_pct):
	call_deferred("_switch_level", level_str, gate_str, offset_pct)


func _ready():
	$UI/StartMenu.open_ui()
