extends VBoxContainer


onready var join_lobby_settings: Join_Lobby_Settings = Global.join_lobby_settings

func _ready():
	load_state()
	get_tree().connect("connected_to_server", self, "on_connect_to_server")
	Game.connect("start_game", self, "on_start_game")
	

func _on_Create_Game_Button_pressed():
	var valid = check_name()
	if valid:
		save()
		get_tree().change_scene_to(Scenes.create_lobby_screen)

func _on_Join_Game_Button_pressed():
	var valid = check_name()
	if valid:
		save()
		connect_to_lobby()

func connect_to_lobby(): 
	var ip_address = $HBoxContainer4/IP_Line_Edit.text
	var address = ip_address.split(":")[0]
	var port_string = ip_address.split(":")[1]
	var port = int(port_string)
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(address,port)
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)
	
func on_start_game(session):
	print("start call received by server!")
	Global.game_session = session
	print("Session_Json:" + session.as_json())
	get_tree().change_scene_to(Scenes.lobby_screen)

func on_connect_to_server():
	if Global.is_connected:
		return
	Global.is_connected = true
	print("Successfully connected to server")	
	var session = Session.new()
	var username = get_username()
	var peer_id = get_tree().get_network_unique_id()	
	session.username = username
	session.peer_id = peer_id
	var session_dict = session.as_dict()
	var session_json = JSON.print(session_dict)
	
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

func get_username():
	return $HBoxContainer/NameLineEdit.text

func save():
	join_lobby_settings.username = get_username()
	join_lobby_settings.address_line = $HBoxContainer4/IP_Line_Edit.text
	Global.save()

func load_state():
	$HBoxContainer4/IP_Line_Edit.text = join_lobby_settings.address_line
	$HBoxContainer/NameLineEdit.text = join_lobby_settings.username
