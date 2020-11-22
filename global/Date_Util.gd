extends Node
class_name Date_Util

static func parse_to_string(date_time):
	return "%02d.%02d.%02d_%02d:%02d:%02d" % [date_time["year"], date_time["month"],date_time["day"], date_time["hour"], date_time["minute"], date_time["second"]]
