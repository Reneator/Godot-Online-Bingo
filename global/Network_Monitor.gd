extends Node


func _ready():
	get_tree().get_multiplayer().connect("peer_connected",Callable(self,"on_network_peer_connected"))
	get_tree().get_multiplayer().connect("peer_disconnected",Callable(self,"on_network_peer_disconnected"))
	
func on_network_peer_connected(id):
	if Global.is_host:
		print("Host: Client with id: %s connected to Host!"%id)
	else:
		if id == 1:
			print("Client: Connected to Host!")
		print("Client: Additional Client with id: %s connected to Host!"%id)

func on_network_peer_disconnected(id):
	if Global.is_host:
		print("Host: Client with id: %s disconnected from Host!"%id)
	else:
		if id == 1:
			print("Client: Disconnected from Host!")			
		print("Client: Additional Client with id: %s disconnected from Host!"%id)
