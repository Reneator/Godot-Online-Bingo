extends Reference
class_name Session_Manager

#only used by Lobby_Admin
var sessions = []

var session_history = [] # collections of all sessions generated in the current sittings

func get_session(request_session, grid_size):
	var session = check_for_existing_session(request_session)
	if session:
		return session
	session = generate_new(request_session, grid_size)
	return session

func generate_new(request_session, grid_size):
	archive_session(request_session.username)
	var session = Session.new()
	session.peer_id = request_session.peer_id
	var entries = select_bingo_entries(Global.bingo_entries, grid_size)
	var is_duplicate = check_duplicate(entries)
	session.bingo_entries = entries
	session.grid_size = grid_size
	return session

func check_duplicate(entries):
	pass

func archive_session(username):
	for session in sessions:
		if session.username == username:
			session_history.append(session)
			session.remove(session)

func check_for_existing_session(request_session : Session):
	for session in sessions:
		if session.username == request_session.username:
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
