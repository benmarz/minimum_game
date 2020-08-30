extends CanvasLayer

onready var default_menu = $PauseMenu

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			for node in get_children():
				node.close_menu()
			get_tree().paused = false
		else:
			default_menu.open_ui()
