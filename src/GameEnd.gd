extends Control

var press_any_key := false

#warning-ignore:unused_signal
signal switch_menu(menu_name)
signal restart_game

# Bad names, but they are necessary to work with UI.gd
func open_menu():
	$PressAnyKey.visible = false
	visible = true
	grab_focus()
	yield(get_tree().create_timer(.5), "timeout")
	press_any_key = true
	$PressAnyKey.visible = true


func close_menu():
	visible = false


func open_ui():
	get_tree().paused = true
	open_menu()


func close_ui():
	close_menu()
	get_tree().paused = false


func _gui_input(event):
	if event.is_action_type():
		if press_any_key:
			close_ui()
			emit_signal("restart_game")
		accept_event()
