extends PanelContainer

var is_valid

var creation_date

signal pressed()

var pressed setget set_pressed

func set_pressed(_pressed):
	$Button.pressed = _pressed

func get_pressed():
	return $Button.pressed

func refresh():
	if get_pressed():
		if is_valid:
			modulate = Color.green
		else:
			modulate = Color.red
	else:
		if is_valid:
			modulate = Color.blue

func set_text(text):
	$Label.text = text

func to_string():
	return "%s,%s" %[$Label.text, get_pressed()]

func get_state():
	return str(get_pressed())
	
func _on_Button_pressed():
	emit_signal("pressed")
