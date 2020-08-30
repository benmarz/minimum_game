extends UIMenu

signal start_game

func menu_action(action_str):
	match action_str:
		"Start":
			close_ui()
			emit_signal("start_game")
		"Quit":
			get_tree().quit()
