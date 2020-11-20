extends Node
class_name Lobby_Settings


var ip_address = "127.0.0.1:37256"

var max_players = 100

var grid_size = 4

var port = 37256

var upnp : UPNP


func clean_up():
	if upnp:
		upnp.delete_port_mapping(port)


func load_state(save_dict):

	ip_address = save_dict.get("saved_ip_address")
