extends Node

func save_game():
	print("saving game to ", OS.get_user_data_dir())
	var save_file = File.new()
	if save_file.open(Global.SAVE_FILE, File.WRITE) != 0:
		print("can't open save file at ", Global.SAVE_FILE)
	else:
		save_file.store_var(Global.level)
		save_file.store_var(Global.gate)
		save_file.store_var(Global.treasures)
		save_file.close()

func load_game():
	print("loading game from ", OS.get_user_data_dir())
	var save_file = File.new()
	if not save_file.file_exists(Global.SAVE_FILE):
		print("can't file save file at", Global.SAVE_FILE)
		return
	if save_file.open(Global.SAVE_FILE, File.READ) != 0:
		print("can't open save file at ", Global.SAVE_FILE)
	else:
		Global.level = save_file.get_var()
		Global.gate = save_file.get_var()
		Global.treasures = save_file.get_var()
		Global.curr_treasures = {}
		save_file.close()


func remove_save():
	var dir := Directory.new()
	if dir.file_exists(Global.SAVE_FILE) and dir.remove(Global.SAVE_FILE) != 0:
		print("can't remove save file at ", Global.SAVE_FILE)


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
	# Not sure why I need to wait two frames if not called during a physics
	# frame. Insted of this, I could remove and player from the scene tree and
	# re-add them. I'm pretty certain that this will work.
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	Global.player.enable()


func connect_gates(level: Node):
	for idx in level.get_child_count():
		var node = level.get_child(idx)
		if node is Gate:
			node.connect("exitted_scene", self, "_on_exitted_scene")


# must be called in idle state
func _reset_game():
	Global.enemies = {}
	Global.curr_treasures = {}
	Global.treasures = {}
	var old_level = $Level.get_child(0)
	# TODO: check if we actually got a child
	$Level.remove_child(old_level)
	old_level.free()
	$UI/StartMenu.open_ui()

# must be called in idle state
func _switch_level(level_str: String, gate_str: String, offset_pct: float, save: bool):
	var old_level = $Level.get_child(0)
	# TODO: check if we actually got a child
	$Level.remove_child(old_level)
	old_level.free()
	Global.merge_treasures()
	$Fadeout/ColorRect.color = Color(0, 0, 0, 0)
	_load_level(level_str, gate_str, offset_pct)
	if (save):
		save_game()


func reload_level():
	Global.enemies = {}
	Global.curr_treasures = {}
	$Fadeout/AnimationPlayer.play("fadeout")
	yield($Fadeout/AnimationPlayer, "animation_finished")
	call_deferred("_switch_level", Global.level, Global.gate, 0, false)


func continue_game():
	load_game()
	call_deferred("_load_level", Global.level, Global.gate, 0)


func start_game():
	remove_save()
	call_deferred("_load_level", "res://src/levels/Level1.tscn", "StartGate", 0)


func restart_game():
	call_deferred("_reset_game")


func _on_exitted_scene(level_str, gate_str, offset_pct):
	call_deferred("_switch_level", level_str, gate_str, offset_pct, true)


func _ready():
	$UI/StartMenu.open_ui()
