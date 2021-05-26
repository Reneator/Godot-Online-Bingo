extends Control

var session_manager = Session_Manager.new()

var full_ip_string

onready var create_lobby_settings: Create_Lobby_Settings = Global.create_lobby_settings

func _ready():
	Game.connect("client_ready", self, "on_client_ready")
	Game.connect("update_client_session", self, "on_update_client_session")
#	Game.connect("bingo_confirmed", self, "on_bingo_confirmed")
	Events.connect("admin_username_clicked", self, "on_username_clicked")
	get_tree().connect("network_peer_disconnected", self, "on_network_peer_disconnected")
	$HTTPRequest.connect("request_completed", self, "on_request_completed")
	$HTTPRequest.request("https://api.ipify.org")
	$Bingo_Confirm_Popup.connect("confirmed", self, "on_bingo_confirmed")
	$Lobby_Admin/HBoxContainer2/Bingo_Entries_Container.initialize(Global.bingo_entries)
	$Bingo_Confirm_Popup.validator = $Lobby_Admin/HBoxContainer2/Scroll/Entries_Log

func on_request_completed(result, response_code, headers, body):
	var string = body.get_string_from_utf8()
	var ip = string
	var port = str(Global.upnp_port)
	$Lobby_Admin/HBoxContainer/HBoxContainer/IP_Address.text = ip
	$Lobby_Admin/HBoxContainer/HBoxContainer/Port.text = port
	full_ip_string = ip+":"+port

func on_client_ready(request_session):
	print("on_client_ready!")
	
	var username_used = session_manager.check_is_session_connected(request_session)
	if username_used:
		var error_message = "Username \"%s\" already connected! Please choose another name!" % request_session.username
		Game.rpc_id(request_session.peer_id, "server_error_message",error_message)
		return

	var client_session = session_manager.get_session(request_session, create_lobby_settings.grid_size)
	add_user(client_session)
	var client_session_json = client_session.as_json()

	Game.rpc_id(client_session.peer_id, "start_game", client_session_json)

func add_user(session):
	$Lobby_Admin/HBoxContainer2/User_List.add_user(session)

func on_bingo_confirmed(confirmed_session : Session):
	var grid_size = create_lobby_settings.grid_size
	var new_session = session_manager.generate_new(confirmed_session, grid_size)
	var session_json = new_session.as_json()
	Game.rpc_id(confirmed_session.peer_id, "new_bingo", session_json)

func on_update_client_session(session: Session):
	session_manager.update_session(session)
	var is_bingo = check_bingo(session)
	if is_bingo:
		var bingo_session : Session = session_manager.get_session_by_username(session.username)
		var bingo_validation_entries = $Lobby_Admin/HBoxContainer2/Scroll/Entries_Log.validate_entries(bingo_session.bingo_entries, bingo_session.creation_date)
		bingo_session.bingo_entries_validation = bingo_validation_entries
		$Bingo_Confirm_Popup.add_session(bingo_session)

func check_bingo(session: Session):
	return Bingo.check_for_bingo(session.bingo_entries_states)

func _on_Copy_IP_Button_pressed():
	OS.set_clipboard(full_ip_string)
	
	var clip_board = OS.get_clipboard()
	if clip_board == full_ip_string:
		print("Copied successfully")

func on_username_clicked(username):
	var session = session_manager.check_for_existing_session(username)
	var popup_bingo = $Bingo_Popup/VBoxContainer/Bingo
	popup_bingo.disabled = true
	popup_bingo.initialize_with_session(session, false)
	$Bingo_Popup.show()

func on_network_peer_disconnected(id):
	session_manager.disconnect_session(id)

func _on_Close_Button_pressed():
	$Bingo_Popup.hide()
	pass # Replace with function body.


func _on_Confirm_Button_pressed():
	$Bingo_Confirm_Popup.hide()


func _on_Reject_Button_pressed():
	$Bingo_Confirm_Popup.hide()
