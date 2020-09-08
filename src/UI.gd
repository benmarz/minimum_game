extends CanvasLayer

onready var default_menu = $PauseMenu
var disabled := false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			for node in get_children():
				node.close_menu()
			get_tree().paused = false
		elif not disabled:
			default_menu.open_ui()


func _on_switch_menu(menu_name):
	var old_menu = null
	var found := false
	for node in get_children():
		if node.visible:
			old_menu = node
		if node.name != menu_name:
			node.close_menu()
		else:
			node.open_menu()
			found = true
	if not found and old_menu != null:
		old_menu.open_menu()


func _ready():
	for node in get_children():
		node.connect("switch_menu", self, "_on_switch_menu")
