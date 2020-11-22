extends VBoxContainer

export (PackedScene) var log_entry_scene

func _ready():
	Events.connect("bingo_entry_pressed", self, "add_entry")

func add_entry(entry_value):
	var date_time = OS.get_datetime()
	var log_entry = log_entry_scene.instance()
	log_entry.entry = entry_value
	log_entry.time_stamp = date_time
	add_child(log_entry)

func validate_entries(entries, time_stamp):
	var validation_entries = []
	var log_entries = get_log_entries_after_time(time_stamp)
	for entry in entries:
		if log_entries.has(entry):
			validation_entries.append(true)
		else:
			validation_entries.append(false)
	return validation_entries

func get_log_entries_after_time(time_stamp):
	var log_entries = []
	for child in get_children():
		if child.is_created_after(time_stamp):
			log_entries.append(child.entry)
	return log_entries
