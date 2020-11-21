extends HBoxContainer

var username

func initialize(_username):
	username = _username
	$Button.text = username

func _on_Button_pressed():
	Events.emit_signal("admin_username_clicked", username)
