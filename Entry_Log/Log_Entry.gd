extends Control

var entry_nr : int
var entry : String
var time_stamp : Dictionary # datetime
var date_string : String

@onready var label = $Label

func _ready():
	var _date_string = get_date_string()
	var time_string = _date_string.split("_")[1]
	label.text = "%s:%s" % [time_string, entry]

func get_date_string():
	if String_Util.is_empty_or_null(date_string):
		date_string = Date_Util.parse_to_string(time_stamp)
	return date_string

func is_created_after(_time_stamp): # checks if the Log_entry was created after the input time_stamp
	var compare_date_string
	if _time_stamp is Dictionary:
		compare_date_string = Date_Util.parse_to_string(_time_stamp)
	elif _time_stamp is String:
		compare_date_string = _time_stamp
	else:
		print("incompatible Data-type used in is_created_after in Log_Entry")
		return false
	return get_date_string() > compare_date_string


func _on_Delete_Button_pressed():
	queue_free()
