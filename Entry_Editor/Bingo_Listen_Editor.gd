extends Control


export (PackedScene) var List_Element

var entries = []

func initialize(_entries):
	entries = _entries
	for entry in entries:
		create_entry(entry)

func create_entry(text):
	var entry = List_Element.instance()
	entry.connect("removed", self, "on_entry_removed")
	entry.text = text
	$VBoxContainer/Entries.add_child(entry)

func on_entry_removed(text):
	entries.remove(text)

func _on_Button_pressed():
	clear_error()
	var text = $VBoxContainer/HBoxContainer/LineEdit.text
	process_text(text)

func process_text(text):
	var valid = valid_text(text)
	if not valid:
		return
	entries.append(text)
	create_entry(text)
	
func valid_text(text):
	if text == "" or not text:
		return false
	if entries.has(text):
		return false
	
	return true

func clear_error():
	$VBoxContainer/Error_Label.text = ""

func print_error(text):
	$VBoxContainer/Error_Label.text = text

func _on_LineEdit_text_entered(new_text):
	process_text(new_text)
