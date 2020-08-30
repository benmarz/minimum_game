class_name MenuItem

extends Control

const COLOR_SELECTED = Color(1, 1 ,1 ,1)
const COLOR_UNSELECTED = Color(.5, .5, .5, 1)

func _ready():
	modulate = COLOR_UNSELECTED


func selected(is_true: bool):
	modulate = COLOR_SELECTED if is_true else COLOR_UNSELECTED
