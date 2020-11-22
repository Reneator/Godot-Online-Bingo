extends Label

var entry : String
var time_stamp : Dictionary # datetime
var date_string : String


func _ready():
	var date_string = get_date_string()
	var time_string = date_string.split("_")[1]
	text = "%s:%s" % [time_string, entry]

func get_date_string():
	if not date_string:
		date_string = Date_Util.parse_to_string(time_stamp)
	return date_string

func is_created_after(time_stamp): # checks if the Log_entry was created after the input time_stamp
	var compare_date_string
	if time_stamp is Dictionary:
		compare_date_string = Date_Util.parse_to_string(time_stamp)
	elif time_stamp is String:
		compare_date_string = time_stamp
	else:
		print("incompatible Data-type used in is_created_after in Log_Entry")
		return false
	return get_date_string() > compare_date_string
