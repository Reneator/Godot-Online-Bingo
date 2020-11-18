extends VBoxContainer



func _on_OK_Button_pressed():
	check_params()
	get_tree().change_scene_to(Scenes.lobby_admin_screen)

func check_params():
	pass

func _on_Cancel_Button_pressed():
	get_tree().change_scene_to(Scenes.main_menu)

func _on_Edit_List_Button_pressed():
	get_tree().change_scene_to(Scenes.list_editor)
