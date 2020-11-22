extends PanelContainer


var bingo_queue = [] #sessions

var validator

var current_session

signal confirmed(session)
signal rejected(session)

func add_session(session: Session):
	bingo_queue.append(session)
	start_session()
		#add check_with_log

func start_session():
	show()
	if not current_session:
		current_session = bingo_queue.pop_front()
		$VBoxContainer/Bingo.initialize_with_session(current_session)

func next_session():
	current_session = null
	if bingo_queue.size() > 0:
		 start_session()
		
func _on_Confirm_Button_pressed():
	emit_signal("confirmed", current_session)
	next_session()
	if not current_session:
		hide()

func _on_Reject_Button_pressed():
	emit_signal("rejected", current_session)
	next_session()
	if not current_session:
		hide()
