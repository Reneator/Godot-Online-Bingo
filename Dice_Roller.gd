extends Control
class_name Dice_Roller

func _ready():
	randomize()
	var multiplayer = get_tree()
	print("blubb")

func _on_Button_pressed():
	error_message("")
	
	var number_of_throws = $VBoxContainer/HBoxContainer/Number_Of_Throws.text	
	var dice_sides = $VBoxContainer/HBoxContainer/Dice_Sides.text
	var repetition = $VBoxContainer/HBoxContainer/CheckBox.pressed
	
	if not number_of_throws or number_of_throws.is_empty():
		error_message("Bitte Anzahl der Würfelwürfe angeben")
		return
		
	if not dice_sides or dice_sides.is_empty():
		error_message("Bitte Würfelseiten-anzahl angeben!")
		return
	var rolls = roll_dice_multiples(dice_sides, number_of_throws, repetition)
	
	var throws = ""
	for number in rolls:
		throws += "%d\n" % number
	
	$VBoxContainer/Label.text = throws

static func roll_dice_multiples(dice_sides, number_of_throws, repetition = false):
	var rolls = []
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
	return rolls

static func roll_dice(dice_sides):
	var rolled = randf_range(1, int(dice_sides)+1)
	var number = int(rolled)
	return number

func error_message(error_message):
	$VBoxContainer/Error_Label.text = error_message

