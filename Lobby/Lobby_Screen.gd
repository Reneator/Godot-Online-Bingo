extends VBoxContainer

onready var join_lobby_settings : Join_Lobby_Settings = Global.join_lobby_settings

func _ready():
	$Bingo.connect("change", self, "on_bingo_change")
	$Bingo.connect("bingo", self, "on_bingo")
	Game.connect("bingo_confirmed", self, "on_bingo_confirmed")
	Game.connect("new_bingo", self, "on_new_bingo")
	load_game()

func load_game():
	var session : Session = Global.game_session
	$HBoxContainer/Username_Label.text = join_lobby_settings.username
	$HBoxContainer2/Lobby_Nr_Label.text = str(session.lobby_key)
	$Bingo.initialize(session.bingo_entries,session.grid_size)
	
func on_bingo_change(bingo_state):
	var current_session : Session = Global.game_session
	var update_session = Session.new()
	update_session.username = current_session.username
	update_session.bingo_entries_state = bingo_state
	var session_json = update_session.as_json()
	Game.rpc_id(1, "update_client_session", session_json)
	

func on_bingo_confirmed(session: Session):
	if session.username == join_lobby_settings.username:
		Global.bingo_score += 1
	else:
		var text = "User %s got a Bingo!" % session.username
		$Control/AcceptDialog.popup()

func on_new_bingo(session: Session):
	$Bingo.initialize(session.bingo_entries)

func on_bingo():
	var session_json = Global.game_session.as_json()
	rpc_id(1, "bingo", session_json)
