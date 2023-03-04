extends VBoxContainer


onready var join_lobby_settings: Join_Lobby_Settings = Global.join_lobby_settings

func _ready():
	load_state()
	get_tree().connect("connected_to_server", self, "on_connect_to_server")
	get_tree().connect("server_disconnected", self, "on_disconnected")
	Game.connect("start_game", self, "on_start_game")
	Game.connect("server_error_message", self, "on_server_error_message")
	
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
	var create_client_result = peer.create_client(address,port)
	print(create_client_result)
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)
	
func on_start_game(session):
	print("start call received by server!")
	Global.game_session = session
	print("Session_Json:" + session.as_json())
	get_tree().change_scene_to(Scenes.lobby_screen)

func on_connect_to_server():
	Global.is_connected = true
	var username = get_username()
	var peer_id = get_tree().get_network_unique_id()
	var session = Session.new()	
	session.username = username
	session.peer_id = peer_id
	var session_json = session.as_json()
	Game.rpc_id(1,"client_ready", session_json)
	print("Successfully connected to server")	

func on_disconnected():
	Global.is_connected = false
	print("Client: Disconnected from server!")
	
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

func on_server_error_message(error_message):
	print_error(error_message)
