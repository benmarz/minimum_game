class_name UIMenu
extends Control

#warning-ignore:unused_signal
signal switch_menu(menu_name)

var selected_id := 0
export var menu_path : NodePath = "Menu"
onready var menu = get_node(menu_path)


func find_first_visible_id():
	for id in menu.get_child_count():
		var node = menu.get_child(id)
		if node.visible:
			return id
	return selected_id


func find_next_visible_id():
	for id in range(selected_id + 1, menu.get_child_count()):
		var node = menu.get_child(id)
		if node.visible:
			$Switch.play()
			return id
	return selected_id


func find_prev_visible_id():
	for id in range(selected_id - 1, -1, -1):
		var node = menu.get_child(id)
		if node.visible:
			$Switch.play()
			return id
	return selected_id


func change_selected(new_id: int):
	if new_id >= 0 and new_id < menu.get_child_count():
		selected_id = new_id
		for id in menu.get_child_count():
			var node = menu.get_child(id)
			if node is MenuItem:
				node.selected(id == selected_id)


func open_ui():
	get_tree().paused = true
	open_menu()


func close_ui():
	close_menu()
	get_tree().paused = false


func open_menu():
	visible = true
	grab_focus()
	change_selected(find_first_visible_id())


func close_menu():
	visible = false


func menu_action(action_str):
	print(action_str, " selected")


func _gui_input(event):
	if event.is_action_pressed("ui_up"):
		change_selected(find_prev_visible_id())
	elif event.is_action_pressed("ui_down"):
		change_selected(find_next_visible_id())
	elif event.is_action_pressed("ui_accept"):
		menu_action(menu.get_child(selected_id).name)
	if event.is_action_type():
		accept_event()
