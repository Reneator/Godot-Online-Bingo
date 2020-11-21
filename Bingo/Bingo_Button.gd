extends Button

func to_string():
	return "%s,%s" %[text, pressed]

func get_state():
	return to_string()
	
