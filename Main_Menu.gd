extends VBoxContainer


func _ready():
	load_state()

func _on_Create_Game_Button_pressed():
	var valid = check_name()
	if valid:
		save()
		get_tree().change_scene("res://Create_Lobby_Screen.tscn")

func _on_Join_Game_Button_pressed():
	var valid = check_name()
	if valid:
		var session = connect_to_lobby()
		if session:
			Global.session = session
			save()
			get_tree().change_scene_to(Scenes.lobby_screen)

func connect_to_lobby():
	var session = Session.new()
	var user_name = get_user_name()
	var lobby_key = $HBoxContainer2/Lobby_Key_Line_Edit.text
	session.username = user_name
	session.lobby_key = lobby_key
	session.grid_size = 3
	session.entries = ["1","2","3","4","5","6","7","8","9"]
	session.lobby_key = "1337"
	
	return session
	
func check_name():
	clear_error()
	var name_text = $HBoxContainer/NameLineEdit.text
	var valid = name_text and name_text != ""
	if not valid:
		print_error("Please enter a correct Name!")
	return valid

func check_lobby_key():
	#check server connection
	return true

func clear_error():
	$ErrorLabel.text = ""

func print_error(text):
	$ErrorLabel.text = text

func get_user_name():
	return $HBoxContainer/NameLineEdit.text

func save():
	Global.user_name = get_user_name()
	Global.lobby_key = $HBoxContainer2/Lobby_Key_Line_Edit.text

func load_state():
	$HBoxContainer/NameLineEdit.text = Global.user_name
	$HBoxContainer2/Lobby_Key_Line_Edit.text = Global.lobby_key
