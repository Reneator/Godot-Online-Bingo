extends VBoxContainer


func _ready():
	load_state()
	get_tree().connect("connected_to_server", self, "on_connect_to_server")
	Game.connect("start_game", self, "on_start_game")
	

func _on_Create_Game_Button_pressed():
	var valid = check_name()
	if valid:
		save()
		get_tree().change_scene("res://Create_Lobby_Screen.tscn")

func _on_Join_Game_Button_pressed():
	var valid = check_name()
	if valid:
		connect_to_lobby()
#		if session:
#			Global.session = session
#			save()
#			get_tree().change_scene_to(Scenes.lobby_screen)

func connect_to_lobby(): 
	var ip_address = $HBoxContainer4/IP_Line_Edit.text
	var address = ip_address.split(":")[0]
	var port_string = ip_address.split(":")[1]
	var port = int(port_string)
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(address,port)
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)
	Global.is_host = false
	

func on_start_game(session_json):
	print("start call received by server!")
	var session = Session.new().from_json(session_json)
	Global.session = session
	save()
	get_tree().change_scene_to(Scenes.lobby_screen)

	

func on_connect_to_server():
	if Global.is_connected:
		return
	Global.is_connected = true
	print("Successfully connected to server")	
	var session = Session.new()
	var user_name = get_user_name()
	var peer_id = get_tree().get_network_unique_id()	
#	var lobby_key = $HBoxContainer2/Lobby_Key_Line_Edit.text
	session.username = user_name
#	session.lobby_key = lobby_key
#	session.grid_size = 3
	session.peer_id = peer_id
#	session.entries = ["1","2","3","4","5","6","7","8","9"]
#	Game.rpc_id()	
#	Game.set_network_master(peer_id)
	var session_dict = session.as_dict()
	var session_json = JSON.print(session_dict)
	print("Session_Json:" + session_json)
	
	Game.rpc_id(1,"client_ready", session_json)

	
	
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
	Global.saved_ip_address = $HBoxContainer4/IP_Line_Edit.text

func load_state():
	$HBoxContainer4/IP_Line_Edit.text = Global.saved_ip_address
	$HBoxContainer/NameLineEdit.text = Global.user_name
	$HBoxContainer2/Lobby_Key_Line_Edit.text = Global.lobby_key
