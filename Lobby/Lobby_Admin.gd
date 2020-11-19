extends Control

var session_manager = Session_Manager.new()


func _ready():
	Game.connect("client_ready", self, "on_client_ready")
	
func on_client_ready(request_session):
	print("on_client_ready!")

	var client_session = session_manager.get_session(request_session)
	var client_session_json = client_session.as_json()

	Game.rpc_id(client_session.peer_id, "start_game", client_session_json)
