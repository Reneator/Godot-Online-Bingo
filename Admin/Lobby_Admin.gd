extends Control

var session_manager = Session_Manager.new()

var full_ip_string

onready var create_lobby_settings: Create_Lobby_Settings = Global.create_lobby_settings

func _ready():
	Game.connect("client_ready", self, "on_client_ready")
	Game.connect("update_client_session", self, "on_update_client_session")
	Game.connect("bingo_confirmed", self, "on_bingo_confirmed")
	Events.connect("admin_username_clicked", self, "on_username_clicked")
	$HTTPRequest.connect("request_completed", self, "on_request_completed")
	$HTTPRequest.request("https://api.ipify.org")
	$HBoxContainer2/Bingo_Entries_Container.connect("entry_clicked", self, "on_entry_clicked")
	$HBoxContainer2/Bingo_Entries_Container.initialize(Global.bingo_entries)
	$Control/Bingo_Confirm_Popup.validator = $HBoxContainer2/Entries_Log

func on_request_completed(result, response_code, headers, body):
	var string = body.get_string_from_utf8()
	var ip = string
	var port = str(Global.upnp_port)
	$HBoxContainer/HBoxContainer/IP_Address.text = ip
	$HBoxContainer/HBoxContainer/Port.text = port
	full_ip_string = ip+":"+port

func on_client_ready(request_session):
	print("on_client_ready!")

	var client_session = session_manager.get_session(request_session, create_lobby_settings.grid_size)
	add_username(request_session.username)
	var client_session_json = client_session.as_json()

	Game.rpc_id(client_session.peer_id, "start_game", client_session_json)

func add_username(username):
	$HBoxContainer2/User_List.add_username(username)

func on_bingo_confirmed(confirmed_session : Session):
	var grid_size = create_lobby_settings.grid_size
	var new_session = session_manager.generate_new(confirmed_session, grid_size)
	var session_json = new_session.as_json()
	rpc_id(confirmed_session.peer_id, "new_bingo", session_json)

func on_update_client_session(session: Session):
	session_manager.update_session(session)
	var is_bingo = check_bingo(session)
	if is_bingo:
		$Control/Bingo_Confirm_Popup.show()
		

var bingo_queue = [] #sessions

func check_bingo(session):
	

func _on_Copy_IP_Button_pressed():
	OS.set_clipboard(full_ip_string)
	
	var clip_board = OS.get_clipboard()
	if clip_board == full_ip_string:
		print("Copied successfully")

func on_username_clicked(username):
	var session = session_manager.check_for_existing_session(username)
	var popup_bingo = $Control/Bingo_Popup/VBoxContainer/Bingo
	popup_bingo.disabled = true
	popup_bingo.initialize_with_session(session)
	$Control/Bingo_Popup.show()


func _on_Close_Button_pressed():
	$Control/Bingo_Popup.hide()
	pass # Replace with function body.


func _on_Confirm_Button_pressed():
	$Control/Bingo_Confirm_Popup.hide()


func _on_Reject_Button_pressed():
	$Control/Bingo_Confirm_Popup.hide()
