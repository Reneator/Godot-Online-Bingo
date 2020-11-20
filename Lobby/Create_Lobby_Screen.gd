extends VBoxContainer

onready var create_lobby_settings : Create_Lobby_Settings = Global.create_lobby_settings

func _ready():
	load_state()

func _on_OK_Button_pressed():
	var valid = check_params()
	if not valid:
		return
	var activated_upnp = activate_upnp()
	if not activated_upnp:
		return
	create_server()
	Global.is_host = true
	save()
	Global.save()
	get_tree().change_scene_to(Scenes.lobby_admin_screen)

func activate_upnp():
	var port = create_lobby_settings.port
	var upnp = UPNP.new()
	var discover_results = upnp.discover()
	var result = upnp.add_port_mapping(port)
	match result:
		UPNP.UPNP_RESULT_SUCCESS:
			Global.upnp = upnp
			Global.upnp_port = port
			return true
		_:
			print_error("Port could not be registered. Is UPNP active on your Router and your Device allowed to set Ports via UPNP?")

func create_server():
	var port = get_port()
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(port, 100)
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)
	print("Server created!")

func check_params():
	clear_error()
	var port_text = $HBoxContainer4/Port_Line_Edit.text
	if not port_text.is_valid_integer():
		print_error("Please define a number for the port!")
		return false
	
	var entries = Global.bingo_entries
	var grid_size = get_grid_size()
	if entries.size() < grid_size*grid_size:
		print_error("Not enough Entries. Need at least %d entries" % [grid_size*grid_size])
		return false
	#list-size has to be at least as big as the bingo-grid-square-size (so for 3 grid-size at least 9)
	return true

func _on_Cancel_Button_pressed():
	save()
	get_tree().change_scene_to(Scenes.main_menu)

func _on_Edit_List_Button_pressed():
	save()
	get_tree().change_scene_to(Scenes.list_editor)

func get_grid_size():
	return int($HBoxContainer/Grid_Size.value)

func get_port():
	return int($HBoxContainer4/Port_Line_Edit.text)

func save():
	var grid_size = get_grid_size()
	create_lobby_settings.grid_size = grid_size
	var port = get_port()
	create_lobby_settings.port = port

func load_state():
	var entries = Global.bingo_entries
	$HBoxContainer2/List_Size_Label.text = str(entries.size())
	
	var grid_size = create_lobby_settings.grid_size
	$HBoxContainer/Grid_Size.value = float(grid_size)
	
	var port = create_lobby_settings.port
	$HBoxContainer4/Port_Line_Edit.text = str(port)

func print_error(text):
	$Error_Label.print_error(text)

func clear_error():
	$Error_Label.clear()
