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
	var entries = generate_entries(grid_size)
	session.bingo_entries = entries
	session.grid_size = grid_size
	return session

func generate_entries(grid_size, tries = 0, max_tries = 5):
	if tries > max_tries:
		print("Session Manager tried to generate new Bingo entries, but had duplicates for %d times while max tries are %d so it got cancelled" %[tries, max_tries])
		return null
	var entries = select_bingo_entries(Global.bingo_entries, grid_size)
	var is_duplicate = check_duplicate(entries)
	if is_duplicate:
		return generate_entries(tries, max_tries)
	else:
		return entries

func update_session(update_session : Session):
	var session : Session = check_for_existing_session(update_session)
	if not session:
		print("No session found to update! Discarded Session Update!")
		return
	session.bingo_entries_state = update_session.bingo_entries_state

func check_duplicate(entries):
	for session in session_history:
		if compare_arrays(session, entries):
			return true
	for session in sessions:
		if compare_arrays(session, entries):
			return true
	return false

func compare_arrays(array_a, array_b):
	for i in range(array_a.size()):
		if array_a[i] != array_b[i]:
			return false
	return true

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
