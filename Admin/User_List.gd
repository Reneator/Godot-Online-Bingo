extends VBoxContainer

export (PackedScene) var username_element_scene


func add_user(session):
	for child in get_children():
		if child.username == session.username:
			return
	var username_element = username_element_scene.instance()
	add_child(username_element)
	username_element.initialize(session)
	
	
