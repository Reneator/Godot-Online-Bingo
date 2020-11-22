extends Button

var is_valid

var creation_date


func refresh():
	if pressed:
		if is_valid:
			self_modulate = Color.green
		else:
			self_modulate = Color.red
	else:
		if is_valid:
			self_modulate = Color.blue


func to_string():
	return "%s,%s" %[text, pressed]

func get_state():
	return str(pressed)
	
