extends Node
class_name Session_Manager

#only used by Lobby_Admin


var sessions = {} #{username:{session}}

func get_session(request_session):
	var session = Session.new()
	session.peer_id = request_session.peer_id
	session.entries = ["1","2","3","4","5","6","7","8","9"]
	session.grid_size = Global.host_session.grid_size
	return session
