extends Label

var entry : String
var time_stamp : Dictionary # datetime
var date_string : String


func _ready():
	text = "%s:%s" % [time_stamp, entry]

func is_created_after(compare_date_string): # checks if the Log_entry was created after the input time_stamp
	if not date_string:
		date_string = Date_Util.parse_to_string(time_stamp)
	return date_string > compare_date_string
