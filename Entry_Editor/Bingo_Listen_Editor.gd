extends Control


export (PackedScene) var List_Element

var edit_entry : List_Entry #if this value is set the input line instead edits the line_entry

func _ready():
	load_state()

func initialize(_entries):
	for entry in _entries:
		create_entry(entry)

func create_entry(text):
	var entry = List_Element.instance()
	entry.connect("removed", self, "on_entry_removed")
	entry.connect("edit", self, "on_entry_edit")
	entry.text = text
	$VBoxContainer/Entries.add_child(entry)

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
	if text == "" or not text:
		return false
	if has_text(text):
		return false
	
	return true

func get_entries():
	return $VBoxContainer/Entries.get_children()
	
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
	save()
	Global.save()
	get_tree().change_scene_to(Scenes.create_lobby_screen)

func _on_Import_Button_pressed():
	pass # Replace with function body.


func _on_Export_Button_pressed():
	pass # Replace with function body.

func save():
	Global.bingo_entries = get_entries_as_strings()

func load_state():
	var entries_list = Global.bingo_entries
	initialize(entries_list)
