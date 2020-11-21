extends VBoxContainer

export (PackedScene) var username_element_scene


func add_username(username):
	var username_element = username_element_scene.instance()
	add_child(username_element)
	username_element.initialize(username)
	
	
