extends PanelContainer


var entry : set = set_entry

func set_entry(_entry):
	entry = _entry
	$Label.text = entry

func _on_Bingo_Entry_pressed():
	Events.emit_signal("s_bingo_entry_pressed", entry)
