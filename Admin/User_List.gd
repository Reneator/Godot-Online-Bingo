extends VBoxContainer

@export var username_element_scene : PackedScene


func add_user(session):
	for child in get_children():
		if child.username == session.username:
			return
	var username_element = username_element_scene.instantiate()
	add_child(username_element)
	username_element.initialize(session)
	
	
