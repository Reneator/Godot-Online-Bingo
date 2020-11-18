extends VBoxContainer

func _ready():
	$Bingo.connect("change", self, "on_bingo_change")
	load_game()

func load_game():
	var session : Session = Global.session
	$HBoxContainer/Username_Label.text = session.username
	$HBoxContainer2/Lobby_Nr_Label.text = session.lobby_key
	$Bingo.bingo_grid_size = session.grid_size
	$Bingo.initialize(session.entries)
	
func on_bingo_change(entries):
	var current_session : Session = Global.session
	var update_session = Session.new()
	update_session.entries = current_session.entries
	update_session.username = current_session.username
	update_session.lobby_key = current_session.lobby_key
	update_session.grid_size = current_session.grid_size
	update_session.entries = entries
	
	print(update_session)

func _on_Bingo_Button_pressed():
	#bingo button unlocks when bingo is unlocked
	pass
