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
