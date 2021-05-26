extends HBoxContainer

var session : Session
var username

onready var user_connected_color = $ColorRect

func initialize(_session):
	session = _session
	username = session.username
	$Button.text = username

func _process(delta):
	if not session:
		return
	if session.is_connected:
		user_connected_color.color = Color("35a628")
	else:
		user_connected_color.color = Color("a62828")

func _on_Button_pressed():
	Events.emit_signal("admin_username_clicked", username)
