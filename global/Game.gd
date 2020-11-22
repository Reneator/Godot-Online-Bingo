extends Node

signal start_game(session)
signal client_ready(session)
signal call_bingo(session)
signal new_bingo(session)
signal refresh_player_list(player_list_json)
signal bingo_confirmed(session)
signal update_client_session(session)
signal server_error_message(error_message)

remote func start_game(session_json):
	var session = Session.new().from_json(session_json)	
	emit_signal("start_game", session)

remote func client_ready(session_json):
	var session = Session.new().from_json(session_json)	
	emit_signal("client_ready", session)
	
remote func call_bingo(session_json):
	var session = Session.new().from_json(session_json)	
	emit_signal("called_bingo", session)

remote func refresh_player_list(player_list_json): #{player_name: {hits:x, bingo: true/false}
	var dict = JSON.parse(player_list_json).result
	emit_signal("resfresh_player_list", dict)

remote func bingo_change(session_json):
	var session = Session.new().from_json(session_json)
	emit_signal("bingo_changed", session)

remote func bingo_confirmed(session_json):
	var session = Session.new().from_json(session_json)
	emit_signal("bingo_confirmed", session)
	
remote func new_bingo(session_json):
	var session = Session.new().from_json(session_json)
	emit_signal("new_bingo", session)

remote func update_client_session(session_json):
	var session = Session.new().from_json(session_json)
	emit_signal("update_client_session", session)

remote func server_error_message(error_message):
	emit_signal("server_error_message", error_message)
