extends VBoxContainer

onready var join_lobby_settings : Join_Lobby_Settings = Global.join_lobby_settings

var bingo_score = 0

func _ready():
	$Bingo.connect("change", self, "on_bingo_change")
	Game.connect("bingo_confirmed", self, "on_bingo_confirmed")
	Game.connect("new_bingo", self, "on_new_bingo")
	load_game()

func load_game():
	var session : Session = Global.game_session
	$HBoxContainer/Username_Label.text = join_lobby_settings.username
	$HBoxContainer2/Lobby_Nr_Label.text = str(session.lobby_key)
	$Bingo.initialize_with_session(session)
	
func on_bingo_change(bingo_state):
	var current_session : Session = Global.game_session
	var update_session = Session.new()
	update_session.username = current_session.username
	update_session.peer_id = current_session.peer_id
	update_session.bingo_entries_states = bingo_state
	var session_json = update_session.as_json()
	Game.rpc_id(1, "update_client_session", session_json)
	

func on_bingo_confirmed(session: Session):
	bingo_score += 1
	if session.username == join_lobby_settings.username:
		Global.bingo_score += 1
	else:
		var text = "User %s got a Bingo!" % session.username
		$Control/AcceptDialog.popup()

func on_new_bingo(session: Session):
	$HBoxContainer3/Bingo_Score.text = str(bingo_score)
	$Bingo.initialize_with_session(session)

func _on_Menu_Button_pressed():
	multiplayer.network_peer.close_connection()
	get_tree().change_scene_to(Scenes.main_menu)
	pass # Replace with function body.
