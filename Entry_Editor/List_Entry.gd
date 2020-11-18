extends HBoxContainer

var text

signal removed(text)

func _ready():
	$Label.text = text

func _on_Button_pressed():
	emit_signal("removed", text)	
	queue_free()
