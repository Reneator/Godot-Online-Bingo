extends Button

var is_valid

var creation_date

func _ready():
	if not creation_date:
		return
	if is_valid:
		self_modulate = Color.green
	else:
		self_modulate = Color.red


func to_string():
	return "%s,%s" %[text, pressed]

func get_state():
	return str(pressed)
	
