extends Button


var entry setget set_entry

func set_entry(_entry):
	entry = _entry
	text = entry

func _on_Bingo_Entry_pressed():
	Events.emit_signal("bingo_entry_pressed", entry)
