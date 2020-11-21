extends HBoxContainer


var session : Session

func initialize(_session):
	session = _session
	$Label.text = session.username
