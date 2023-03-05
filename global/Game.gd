extends Node

signal s_start_game(session)
signal s_client_ready(session)
signal s_call_bingo(session)
signal s_new_bingo(session)
signal s_refresh_player_list(player_list_json)
signal s_bingo_confirmed(session)
signal s_update_client_session(session)
signal s_server_error_message(error_message)

@rpc("any_peer") func start_game(session_json):
	var session = Session.new().from_json(session_json)	
	emit_signal("s_start_game", session)

@rpc("any_peer") func client_ready(session_json):
	var session = Session.new().from_json(session_json)	
	emit_signal("s_client_ready", session)
	
@rpc("any_peer") func call_bingo(session_json):
	var session = Session.new().from_json(session_json)	
	emit_signal("s_called_bingo", session)

@rpc("any_peer") func refresh_player_list(player_list_json): #{player_name: {hits:x, bingo: true/false}
	var test_json_conv = JSON.new()
	test_json_conv.parse(player_list_json)
	var dict = test_json_conv.get_data()
	emit_signal("s_resfresh_player_list", dict)

@rpc("any_peer") func bingo_change(session_json):
	var session = Session.new().from_json(session_json)
	emit_signal("s_bingo_changed", session)

@rpc("any_peer") func bingo_confirmed(session_json):
	var session = Session.new().from_json(session_json)
	emit_signal("s_bingo_confirmed", session)
	
@rpc("any_peer") func new_bingo(session_json):
	var session = Session.new().from_json(session_json)
	emit_signal("s_new_bingo", session)

@rpc("any_peer") func update_client_session(session_json):
	var session = Session.new().from_json(session_json)
	emit_signal("s_update_client_session", session)

@rpc("any_peer") func server_error_message(error_message):
	emit_signal("s_server_error_message", error_message)
