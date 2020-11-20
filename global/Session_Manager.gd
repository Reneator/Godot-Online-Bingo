extends Node
class_name Session_Manager

#only used by Lobby_Admin

var sessions = {} #{username:{session}}

func get_session(request_session, grid_size):
	var session = Session.new()
	session.peer_id = request_session.peer_id
	var entries = select_bingo_entries(Global.bingo_entries, grid_size)
	session.bingo_entries = entries
	session.grid_size = grid_size
	return session

func select_bingo_entries(entries, grid_size):
	var new_entries = []
	var size = entries.size()
	var rolls = Dice_Roller.roll_dice_multiples(size, grid_size*grid_size)
	for roll in rolls:
		var index = roll - 1
		new_entries.append(entries[index])
	return new_entries
	

func get_player_list():
	return {}

func get_session_by_name(username):
	var id = username
	return
