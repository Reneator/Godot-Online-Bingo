extends Control



func _ready():
	randomize()

var rolls = []


func _on_Button_pressed():
	error_message("")
	
	rolls = []
	
	var number_of_throws = $VBoxContainer/HBoxContainer/Number_Of_Throws.text	
	var dice_sides = $VBoxContainer/HBoxContainer/Dice_Sides.text
	var repetition = $VBoxContainer/HBoxContainer/CheckBox.pressed
	
	if not number_of_throws or number_of_throws.empty():
		error_message("Bitte Anzahl der Würfelwürfe angeben")
		return
		
	if not dice_sides or dice_sides.empty():
		error_message("Bitte Würfelseiten-anzahl angeben!")
		return

			
	while true:
		if rolls.size() >= int(dice_sides):
			break
		if rolls.size() >= int(number_of_throws):
			break

		var number = roll_dice(dice_sides)
		
		if not repetition:
			if rolls.has(number):
				continue
		
		rolls.append(number)
	
	var throws = ""
	for number in rolls:
		throws += "%d\n" % number
	
	$VBoxContainer/Label.text = throws

func error_message(error_message):
	$VBoxContainer/Error_Label.text = error_message


func roll_dice(dice_sides):
	var rolled = rand_range(1, int(dice_sides)+1)
	var number = int(rolled)
	return number
