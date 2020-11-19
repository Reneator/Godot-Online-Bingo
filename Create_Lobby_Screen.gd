extends VBoxContainer



func _on_OK_Button_pressed():
	var valid = check_params()
	if valid:
		create_server()
		save()
		get_tree().change_scene_to(Scenes.lobby_admin_screen)

func create_server():
	var port = int($HBoxContainer4/Port_Line_Edit.text)
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(port, Global.max_players)
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer", peer)
	print("Server created!")



func check_params():
	#list-size has to be at least as big as the bingo-grid-square-size (so for 3 grid-size at least 9)
	return true
	pass

func _on_Cancel_Button_pressed():
	get_tree().change_scene_to(Scenes.main_menu)

func _on_Edit_List_Button_pressed():
	get_tree().change_scene_to(Scenes.list_editor)

func save():
	var session = Session.new()
	session.grid_size = $HBoxContainer/Grid_Size.value
	Global.host_session = session
	pass


func load_state():
	pass
