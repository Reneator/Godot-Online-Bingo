extends HBoxContainer
class_name List_Entry

var text : set = set_text

signal s_removed(text)
signal s_edit(list_entry) #self

func set_text(_text):
	text = _text
	$Label.text = text

func _ready():
	$Label.text = text

func _on_Button_pressed():
	emit_signal("s_removed", text)	
	queue_free()

func _on_Edit_Button_pressed():
	emit_signal("s_edit", self)
