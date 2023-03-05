extends PanelContainer

var is_valid

var creation_date

signal s_pressed()

var pressed : set = set_pressed

@onready var button = $Button
@onready var label = $Button/Label

func set_pressed(_pressed):
	button.button_pressed = _pressed

func get_pressed():
	return button.button_pressed

func refresh():
	if get_pressed():
		if is_valid:
			modulate = Color.GREEN
		else:
			modulate = Color.RED
	else:
		if is_valid:
			modulate = Color.BLUE

func set_text(text):
	label.text = text

func _to_string():
	return "%s,%s" %[$Label.text, get_pressed()]

func get_state():
	return str(get_pressed())
	
func _on_Button_pressed():
	emit_signal("s_pressed")
