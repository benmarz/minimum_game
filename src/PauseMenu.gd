extends UIMenu

signal reload_level
signal restart_game

func _gui_input(event):
	if event.is_action_pressed("ui_cancel"):
		accept_event()
		close_ui()


func menu_action(action_str):
	match action_str:
		"Resume":
			close_ui()
		"Reload":
			close_ui()
			emit_signal("reload_level")
		"Quit":
			close_ui()
			emit_signal("restart_game")
