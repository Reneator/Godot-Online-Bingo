extends Control


@export var List_Element : PackedScene

var edit_entry : List_Entry #if this value is set the input line instead edits the line_entry

func _ready():
	load_state()

func initialize(_entries):
	for entry in _entries:
		create_entry(entry)

func create_entry(text):
	var entry = List_Element.instantiate()
	entry.connect("s_removed",Callable(self,"on_entry_removed"))
	entry.connect("s_edit",Callable(self,"on_entry_edit"))
	entry.text = text
	$VBoxContainer/ScrollContainer/Entries.add_child(entry)

func on_entry_edit(entry : List_Entry):
	edit_entry = entry
	$VBoxContainer/HBoxContainer/LineEdit.text = entry.text
	
func _on_Button_pressed():
	clear_error()
	var text = $VBoxContainer/HBoxContainer/LineEdit.text
	process_text(text)

func process_text(text):
	var valid = valid_text(text)
	if not valid:
		return
	create_entry(text)
	
func valid_text(text):
	if text == null or text == "":
		return false
	if has_text(text):
		return false
	
	return true

func get_entries():
	return $VBoxContainer/ScrollContainer/Entries.get_children()
	
func get_entries_as_strings():
	var entries = []
	for child in get_entries():
		entries.append(child.text)
	return entries

func has_text(text):
	for child in get_entries():
		if child.text == text:
			return true

func clear_error():
	$VBoxContainer/Error_Label.clear()

func print_error(text):
	$VBoxContainer/Error_Label.print_error(text)

func _on_LineEdit_text_entered(new_text):
	$VBoxContainer/HBoxContainer/LineEdit.text = ""
	if edit_entry:
		edit_entry = null
	else:
		process_text(new_text)

func _on_LineEdit_text_changed(new_text):
	if edit_entry:
		edit_entry.text = new_text

func _on_OK_Button_pressed():
	_on_Button_pressed()
	save()
	Global.save()
	get_tree().change_scene_to_packed(Scenes.create_lobby_screen)

func _on_Import_Button_pressed():
	$Control/Import_File_Dialog.popup()

func _on_Export_Button_pressed():
	$Control/Export_File_Dialog.popup()

func save():
	Global.bingo_entries = get_entries_as_strings()

func load_state():
	var entries_list = Global.bingo_entries
	initialize(entries_list)

func _on_Import_File_Dialog_file_selected(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var file_content = file.get_as_text()
	if not file_content is String:
		print_error("File content not String!")
	
	var lines = file_content.split("\n")
	initialize(lines)
	file.close()
	save()

func _on_Export_File_Dialog_file_selected(path):
	var file = FileAccess.open(path, FileAccess.WRITE)
	var entries = get_entries_as_strings()
	var file_line_content = ""
	for entry in entries:
		if not file_line_content == "":
			file_line_content += "\n"
		file_line_content += entry
	file.store_string(file_line_content)
	file.close()
