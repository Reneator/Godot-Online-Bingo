extends VBoxContainer


@export var bingo_entry_scene : PackedScene

func initialize(bingo_entries):
	for entry in bingo_entries:
		var bingo_entry = bingo_entry_scene.instantiate()
		bingo_entry.entry = entry
		$ScrollContainer/Bingo_Entries.add_child(bingo_entry)
