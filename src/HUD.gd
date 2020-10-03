extends CanvasLayer

func _ready():
# warning-ignore:return_value_discarded
	Global.connect("update_treasure", self, "_on_update_treasure")

func _on_update_treasure():
	$MarginContainer/NinePatchRect/HBoxContainer/value.text = str(Global.player.treasures)
